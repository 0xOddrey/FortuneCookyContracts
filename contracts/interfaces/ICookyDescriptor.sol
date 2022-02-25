// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

pragma abicoder v2;


/// @title Describes Onii via URI
interface ICookyDescriptor {

    function _buildFortuneCooky(address _to, uint256 tokenId, uint bgId) external view returns (string memory);

}