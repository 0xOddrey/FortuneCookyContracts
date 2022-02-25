// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


import "./libraries/Base64.sol";
import "./interfaces/ICookyDescriptor.sol";

contract FortuneCooky is ERC721URIStorage,  Ownable {

    using SafeMath for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 public constant MAX_TOKENS = 1000;
    uint256 public constant MAX_MINT = 10;

    bytes4 private constant _INTERFACE_ID_ERC2981 = 0x2a55205a;

    address private transferWallet;

    uint256 public constant LISTING_PRICE = 50000000000000000000;

    ICookyDescriptor iCookyContract;

    mapping(uint256 => address) private _owners;

    mapping(uint256 => uint) bgId;

    event NewFortuneCooky(uint256 indexed id);

    event NewFortune(uint256 indexed id);


    constructor(
        address _transferWallet, 
        address _buildCooky
    ) ERC721("FortuneCooky", "COOKY") {
        transferWallet = _transferWallet;
        iCookyContract = ICookyDescriptor(_buildCooky);
    }



    function getNewFortune(address _to, uint256 tokenId) public  {
        address owner = ownerOf(tokenId);
        require(owner == msg.sender, "You are not the owner");
        uint bg_id = getBgID(_to, tokenId);
        string memory current_date = Strings.toString(block.timestamp);
        string memory finalSvg = iCookyContract._buildFortuneCooky(_to, tokenId, bg_id);
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Fortune Cooky", "description": "Crypto Fortune Cooky", "attributes": [{"display_type": "date", "trait_type": "Fortune Date", "value": "',
                        current_date,
                        '"}], "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _setTokenURI(tokenId, finalTokenUri);

    }

    function getBgID(address _to, uint256 tokenId) public view returns(uint256) {
        if(bgId[tokenId] >= 100){
            uint scaled = bgId[tokenId];
            return scaled; 
        } else {
            uint seed = uint(keccak256(abi.encodePacked('NANYU_ATHENA', _to, block.number, block.timestamp, Strings.toString(tokenId))));
            uint scaled = seed % 999;
            if( 100 > scaled ){
                scaled += 100;
                return scaled;
            } else {
                return scaled;
            }
        }
       
    } 


    function mint(address _to, uint256 _count) external payable  {
        require(_count > 0, "Mint count should be greater than zero");
        require(_count <= MAX_MINT, "Exceeds max items");
        uint256 numTokens = _tokenIdCounter.current();
        require(numTokens <= MAX_TOKENS, "Sale ended");
        require(numTokens + _count <= MAX_TOKENS, "Max limit");
 
        require(msg.value >= LISTING_PRICE.mul(_count), "Insufficient funds");
        
        for (uint256 i = 0; i < _count; i++) {
            _mintOneItem(_to);
        }
    }

    function ownerMintTransfer(address _to, uint256 _count) public  onlyOwner {
        require(_count > 0, "Mint count should be greater than zero");
        require(_count <= MAX_MINT, "Exceeds max items");
        uint256 numTokens = _tokenIdCounter.current();
        require(numTokens <= MAX_TOKENS, "Sale ended");
        require(numTokens + _count <= MAX_TOKENS, "Max limit");
 
        for (uint256 i = 0; i < _count; i++) {
            _mintOneItem(_to);
        }
    }

    function _mintOneItem(address _to) private {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        uint bg_id = getBgID(_to, tokenId);
        string memory current_date = Strings.toString(block.timestamp);
        string memory finalSvg = iCookyContract._buildFortuneCooky(_to, tokenId, bg_id);
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                       '{"name": "Fortune Cooky", "description": "Crypto Fortune Cooky", "attributes": [{"display_type": "date", "trait_type": "Fortune Date", "value": "',
                        current_date,
                        '"}], "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _safeMint(_to, tokenId);
        _setTokenURI(tokenId, finalTokenUri);
        _owners[tokenId] = _to;

    }

    function setRoyalties(uint _tokenId, address payable _royaltiesReceipientAddress, uint96 _percentageBasisPoints) public onlyOwner {
        LibPart.Part[] memory _royalties = new LibPart.Part[](1);
        _royalties[0].value = _percentageBasisPoints;
        _royalties[0].account = _royaltiesReceipientAddress;
        _saveRoyalties(_tokenId, _royalties);
    }


    function royaltyInfo(uint256 _tokenId, uint256 _salePrice) external view returns (address receiver, uint256 royaltyAmount) {
        LibPart.Part[] memory _royalties = royalties[_tokenId];
        if(_royalties.length > 0) {
            return (_royalties[0].account, (_salePrice * _royalties[0].value)/10000);
        }
        return (address(0), 0);
    }

    
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721) returns (bool) {
        if(interfaceId == LibRoyaltiesV2._INTERFACE_ID_ROYALTIES) {
            return true;
        }
        if(interfaceId == _INTERFACE_ID_ERC2981) {
            return true;
        }
        return super.supportsInterface(interfaceId);
    }


    function withdrawAll() public payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0);
        _withdraw(transferWallet, balance);
    }

    function _withdraw(address _address, uint256 _amount) private {
        (bool success, ) = _address.call{ value: _amount }("");
        require(success, "Transfer failed.");
    }



}