// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

pragma abicoder v2;
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/ICookyDescriptor.sol";
import "./libraries/Base64.sol";
import  "./libraries/Lines1.sol";
import  "./libraries/Lines2.sol";
import  "./libraries/Lines3.sol";

contract CookyDescriptor is ICookyDescriptor {


    uint public constant MAX = uint(0) - uint(1); // using underflow to generate the maximum possible value
    uint public constant SCALE = 999;
    uint public constant SCALIFIER = MAX / SCALE;
    uint public constant OFFSET = 100; 

    string[] one = ["#9470ff", "#191f42", "#aa57a9", "#bf2ba9", "#323334", "#635494", "#5b5b5c", "#b487b4", "#004A06", "#636363" ];
    string[] two = ["#a161f4", "#8bd3cb", "#7fa1f3", "#04ccd8", "#9c94cb", "#3097b0", "#940a90", "#98b6ad", "#61E89B", "#CFCFCF" ];
    string[] three = ["#ed5fdc", "#5f7ef6", "#e59974", "#3badf6", "#a0a1cd", "#049393", "#04c8cc", "#bcb5bc", "#12B55F", "#ABABAB" ];


    function _getfortuneText(
        string memory line2,
        string memory line3
    ) internal pure returns (string memory)
        {
        return
            (
                string(
                abi.encodePacked( 
                    '<text x="50%" y="45%" dominant-baseline="middle" text-anchor="middle">',
                    line2,
                    '</text>',
                    '<text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle">',
                    line3,
                    '</text>'
                    )));
        }
    
    function _getCookyImage() 
        internal pure returns (string memory)
        {
        return
            (
                string(
                abi.encodePacked(
                '<path style="fill:#f2a533; stroke:none;" d="M255 161L285 156C285 149.795 286.14 142.497 280 139C284.977 134.24 289.927 129.729 297 129C294.55 148.39 295.914 168.589 295.82 188C295.76 200.482 292.47 213.393 292.011 226C291.673 235.284 290.434 244.891 288.6 254C288.035 256.808 287.744 261.368 285.297 263.288C281.375 266.365 275.445 258.457 273.286 256C263.71 245.101 254.163 232.184 248 219C254.292 225.018 266.487 235.893 274.351 225.891C277.785 221.524 278.531 215.216 280 210L241 215C243.04 221.445 247.284 227.386 251.004 233C261.197 248.385 276.409 275.573 297 276L297 275L291 275C298.164 264.478 298.183 248.358 299.089 236C301.068 209.002 302.839 182.038 304 155L305 155C305.523 180.336 317.635 228.216 345 236.779C363.559 242.587 381.991 234.66 400 232L400 206C400 203.036 400.87 198.232 398.972 195.702C396.514 192.425 389.638 191.638 386 190.139C376.793 186.344 367.825 181.773 360 175.55C357.077 173.226 338.247 158.462 344.622 153.882C347.956 151.486 356.409 159.742 359 161.576C371.143 170.167 385.782 182.469 400 187C399.988 171.115 374.14 159.921 362 151.656C348.652 142.568 335.445 133.081 321 125.756C315.487 122.96 308.391 119.098 302 119.387C296.202 119.648 290.323 124.35 286 127.808C274.655 136.883 262.732 148.639 255 161z"/>',
                '<path style="fill:#d57b29; stroke:none;" d="M280 139C285.121 143.405 284.999 148.661 285 155C299.301 152.888 296.067 140.828 297 129C289.828 129.373 284.199 133.299 280 139z"/>',
                '<path style="fill:#f2a533; stroke:none;" d="M0 215C6.55344 210.383 10.9933 203.668 17.0008 198.424C20.4619 195.403 23.7239 192.239 26.9961 189.015C29.7569 186.295 39.1423 174.986 43.3032 180.337C46.704 184.711 39.3174 195.049 37.2184 199C31.3384 210.068 23.0349 220.323 14 228.961C10.4248 232.379 2.5619 235.703 0.603395 240.213C-2.09168 246.42 0 257.272 0 264C7.09763 260.262 13.7302 255.602 22 255.094C29.2985 254.645 35.8934 257.982 43 258.83C63.5732 261.285 92.1215 258.046 99.6404 235C101.534 229.197 101 223.023 101 217L102 217C106.954 232.655 119.538 248.823 129.151 262C131.726 265.53 136.494 274.287 141.895 273.168C146.299 272.256 148.256 264.598 149.564 261C154.292 247.998 157.259 233.703 159 220C140.941 220 129.847 217.209 114 209.299C110.26 207.433 105.667 207.936 102.634 204.697C94.1523 195.638 88.7269 179.354 84 168L127 168C118.207 157.198 102.981 148.005 91 141.012C86.2444 138.236 79.6415 134.892 74 136.908C68.4461 138.893 64.0492 144.951 60 149L31 178C21.7015 187.299 0.16294 201.203 0 215M294 152L295 153L294 152z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M295 152L296 153L295 152M400 195C399.948 180.349 371.097 169.427 360 161.576C357.111 159.532 348.393 150.922 344.604 153.161C338.569 156.729 350.525 168.384 353.015 170.572C366.33 182.271 382.671 190.991 400 195z"/>',
                '<path style="fill:#f2a533; stroke:none;" d="M291 153L292 154L291 153z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M292 153L293 154L292 153z"/>',
                '<path style="fill:#e7dace; stroke:none;" d="M84 168C88.5867 179.017 94.3499 197.002 102.966 205.397C105.676 208.038 110.718 207.493 114 209.521C144.214 228.185 187.065 218.538 221 217.039C236.071 216.374 251.019 213.949 266 212.155C273.135 211.301 282.366 211.012 287.816 205.786C300.448 193.672 293.995 168.865 296 153C283.868 154.785 272.287 159.395 260.015 160.855C201.403 167.828 142.859 168 84 168z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M288.667 154.333L289.333 154.667L288.667 154.333M285 155L286 156L285 155z"/>',
                '<path style="fill:#d57b29; stroke:none;" d="M304 155C301.924 181.308 301.715 207.697 299.17 234C297.828 247.87 297.449 262.378 291 275C328.689 275 364.304 257.743 400 248L400 232C382.607 233.518 367.115 240.95 349 237.532C322.234 232.483 313.023 195.362 307.881 173C306.545 167.188 306.431 160.414 304 155z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M281 156L282 157L281 156M295 156L295 173L296 173L295 156M276.667 157.333L277.333 157.667L276.667 157.333M272.667 158.333L273.333 158.667L272.667 158.333M266 159L266 160L269 160L266 159M257 160L257 161L263 161L257 160M255 161L256 162L255 161M100 168L100 169L118 169L100 168M125 168L125 169L128 169L125 168M84 169L85 170L84 169M85 171L86 172L85 171M86 173L87 174L86 173M87 175L88 176L87 175M88 177L89 178L88 177M0 239C16.8341 231.945 30.1651 213.882 38.2438 198C40.1729 194.208 48.2401 182.497 42.6782 179.047C37.0543 175.559 27.3562 187.675 24 191C16.883 198.051 4.16434 206.342 0.603395 216C-1.77463 222.45 0 232.165 0 239M89 179L90 180L89 179M90 181L91 182L90 181M294 181L295 182L294 181M91.3333 183.667L91.6667 184.333L91.3333 183.667M295 184L295 192L296 192L295 184M92 186L93 187L92 186M93 188L94 189L93 188M94 190L95 191L94 190M95 192L96 193L95 192M96 194L97 195L96 194M294.333 194.667L294.667 195.333L294.333 194.667M97 196L98 197L97 196M98.3333 197.667L98.6667 198.333L98.3333 197.667M293 198L294 199L293 198M99 199L100 200L99 199z"/>',
                '<path style="fill:#f2a533; stroke:none;" d="M292 199L293 200L292 199z"/>',
                '<path style="fill:#d57b29; stroke:none;" d="M293 199C289.282 204.157 283.574 206.813 279.938 211.495C275.385 217.357 277.085 228.702 267 229.677C259.761 230.378 253.415 222.702 248 219C252.165 232.156 263.542 245.645 272.428 256C274.869 258.844 280.029 265.845 284.581 264.288C288.569 262.923 289.004 253.47 289.562 250C291.509 237.879 292.695 225.254 293.015 213C293.137 208.3 294.868 203.462 293 199z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M100 201L101 202L100 201z"/>',
                '<path style="fill:#f2a533; stroke:none;" d="M291 201L292 202L291 201z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M290 202L291 203L290 202M101 203L102 204L101 203M102 205L103 206L102 205z"/>',
                '<path style="fill:#f2a533; stroke:none;" d="M288 205L289 206L288 205M287 206L288 207L287 206z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M107 207L107 208L110 208L107 207M113 208L114 209L113 208M284 208L285 209L284 208M114 209L115 210L114 209M282 209L283 210L282 209M276 210L276 211L279 211L276 210M271.667 211.333L272.333 211.667L271.667 211.333M263.667 212.333L264.333 212.667L263.667 212.333M253 213L253 214L258 214L253 213M121 214L122 215L121 214M245 214L245 215L248 215L245 214M123 215L124 216L123 215z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M125 216L126 217L125 216z"/>',
                '<path style="fill:#d57b29; stroke:none;" d="M101 217C101 224.691 101.284 231.968 97.598 239C86.5574 260.065 56.4324 262.576 36 257.011C24.7636 253.95 0.525061 253.866 0 270C32.5069 269.979 64.4837 275.876 97 277.3C111.906 277.953 127.524 279.591 142 275L142 274C121.677 263.428 115.285 233.442 101 217z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M128 217L129 218L128 217M132 218L132 219L135 219L132 218z"/>',
                '<path style="fill:#d57b29; stroke:none;" d="M247 218L248 219L247 218z"/>',
                '<path style="fill:#e7c08f; stroke:none;" d="M144 219L144 220L158 220L144 219z"/>',
                '<path style="fill:#f2a533; stroke:none;" d="M397 248L398 249L397 248M392 250L393 251L392 250M389 251L390 252L389 251M386 252L387 253L386 252M383 253L384 254L383 253M380 254L381 255L380 254M377 255L378 256L377 255M374 256L375 257L374 256M371 257L372 258L371 257M368 258L369 259L368 258M364 259L365 260L364 259M361 260L362 261L361 260M358 261L359 262L358 261M355 262L356 263L355 262M351 263L352 264L351 263M347 264L348 265L347 264M343.667 265.333L344.333 265.667L343.667 265.333M340 266L341 267L340 266M336 267L337 268L336 267M332.667 268.333L333.333 268.667L332.667 268.333M9 269L9 270L15 270L9 269M328 269L329 270L328 269M28.6667 270.333L29.3333 270.667L28.6667 270.333M323.667 270.333L324.333 270.667L323.667 270.333M36 271L37 272L36 271M319 271L320 272L319 271M44 272L45 273L44 272M314.667 272.333L315.333 272.667L314.667 272.333M52 273L52 274L55 274L52 273M309.667 273.333L310.333 273.667L309.667 273.333M61 274L61 275L64 275L61 274M303.667 274.333L304.333 274.667L303.667 274.333M70.6667 275.333L71.3333 275.667L70.6667 275.333M81 276L81 277L85 277L81 276M94 277L94 278L100 278L94 277M127 277L127 278L130 278L127 277z"/>' 
                )));
        }

    function _getBackground(
        string memory color1,
        string memory color2,
        string memory color3
    ) internal pure returns (string memory)
        {
        return
            (
                string(
                abi.encodePacked(
                    '<style>.color-anim {animation: col 6s infinite;animation-timing-function: ease-in-out;}@keyframes col {0%,51% {stop-color:none} 52% {stop-color:"',
                    color3,
                    '"} 53%,100% {stop-color:none}}</style><stop offset="0" class="color-anim" style="stop-color:',
                    color1,
                    '"/><stop offset="0.66" style="stop-color:',
                    color2,
                    '"><animate attributeName="offset" dur="18s" values="0.54;0.8;0.54" repeatCount="indefinite" keyTimes="0;.4;1"/></stop>',
                    '<stop offset="1" style="stop-color:',
                    color3,
                    '"><animate attributeName="offset" dur="18s" values="0.86;1;0.86" repeatCount="indefinite"/></stop></linearGradient><rect fill="url(#gradient2)" x="0" y="0" width="400" height="400"/></g>'
                    )));
        }

 
    function _randomish(address _to, uint256 tokenId) public view returns(string[2] memory) {
        uint seed = uint(keccak256(abi.encodePacked('NANYU_ATHENA', block.number, block.timestamp, _to, Strings.toString(tokenId))));
        uint scaled = seed % 60;
        if (scaled >= 41) {
            return Lines3.getFortuneLines(scaled);
        } else if (scaled >= 21) {
            return Lines2.getFortuneLines(scaled);
        } else {
            return Lines1.getFortuneLines(scaled);
        }
        
    }    


    function _buildFortuneCooky(address _to, uint256 tokenId, uint bgId) public view override returns (string memory) {
        uint256 iOne = bgId % 10;
        uint256 iTwo = bgId % 100 / 10;
        uint256 iThree = bgId % 1000 / 100;
        string[2] memory lines = _randomish(_to, tokenId);
        string memory textLines = _getfortuneText(lines[0], lines[1]);
        string memory cooky = _getCookyImage();
        string memory background = _getBackground(one[iOne], two[iTwo], three[iThree]);
        return string(abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" viewBox="0 0 400 400" style="enable-background:new 0 0 420 420;" xml:space="preserve"><g id="Background"><linearGradient id="gradient2" cx="300" cy="-200" r="210.025" gradientTransform="matrix(1 0 0 -1 0 76)" gradientUnits="userSpaceOnUse">', background, cooky, textLines, '</svg>'));

    }  

}