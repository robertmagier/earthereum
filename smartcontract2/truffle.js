module.exports = {
  solc: {
 optimizer: {
   enabled: true,
   runs: 200
 }
},
   networks: {
   development: {
   host: "localhost",
   from:'0x5fbc8dB242257DCf8A0A57f026982256f6B3e0bE',
   port: 8545,
   network_id: "*" // Match any network id
  }
 }
};
