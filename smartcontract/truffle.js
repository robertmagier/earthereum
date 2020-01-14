module.exports = {
  solc: {
 optimizer: {
   enabled: true,
   runs: 200
 }
},
   networks: {
 //   development: {
 //   host: "localhost",
 //   from:'0x2e6676612C69f4d72D2b3CDC8A7e234778f435B4',
 //   port: 8545,
 //   network_id: "987", // Match any network id
 //   gas: 8985897,
 //
 // },
   rinkeby: {
   host: "https://rinkeby.infura.io/FiZkooYHIsk3keP6qjT7",
   from:'0x2e6676612C69f4d72D2b3CDC8A7e234778f435B4',
   // port: ,
   network_id: "4", // Match any network id
   gas: 8985897,

  }
 }
};
