require("@nomiclabs/hardhat-waffle");
let secret = require("./secret")
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 module.exports = {
  solidity: '0.8.2',
  networks: {
    testnet: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/5y2o6GpFZBpPZER0QxV48KRcqZCGOxpL",
      accounts: [secret.key]
    },
    polygon: {
      url: secret.polyurl,
      accounts: [secret.polykey]
    },
  },
};
