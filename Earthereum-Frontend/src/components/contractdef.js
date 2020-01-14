smartContract =  [
  {
    "constant": true,
    "inputs": [],
    "name": "name",
    "outputs": [
      {
        "name": "",
        "type": "string"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_newOwner",
        "type": "address"
      }
    ],
    "name": "transferOwnsership",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance1Share",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance2Active",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance1Attacks",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance2Value",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance1Active",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance2Share",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance2Defenses",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "owner",
    "outputs": [
      {
        "name": "",
        "type": "address"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance1Defenses",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance1Value",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "alliance2Attacks",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "_CR",
        "type": "string"
      },
      {
        "indexed": false,
        "name": "_newOwner",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "_price",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "_warpool",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "_adminFee",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "_continentfee",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "_worldfee",
        "type": "uint256"
      }
    ],
    "name": "BuyTransaction",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "_newstate",
        "type": "uint256"
      }
    ],
    "name": "WorldStateChange",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "_user",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "_alliance",
        "type": "uint256"
      }
    ],
    "name": "AllianceChanged",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "_attacker",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "_CR",
        "type": "bytes3"
      },
      {
        "indexed": false,
        "name": "_attackType",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "_attackvalue",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "defended",
        "type": "bool"
      }
    ],
    "name": "CountryAttacked",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [],
    "name": "NewDefense",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [],
    "name": "TimersUpdated",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [],
    "name": "WarpoolLimitUpdated",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "winner",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "a1value",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "a2value",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "timestamp",
        "type": "uint256"
      }
    ],
    "name": "WarResult",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "user",
        "type": "address"
      },
      {
        "indexed": false,
        "name": "share",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "value",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "timestamp",
        "type": "uint256"
      },
      {
        "indexed": false,
        "name": "attacksNumber",
        "type": "uint256"
      }
    ],
    "name": "UserWarShare",
    "type": "event"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_adr",
        "type": "address"
      }
    ],
    "name": "GetUserName",
    "outputs": [
      {
        "name": "",
        "type": "string"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_name",
        "type": "string"
      }
    ],
    "name": "SetUserName",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetDrawNumber",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      }
    ],
    "name": "GetCountryData",
    "outputs": [
      {
        "name": "_CRout",
        "type": "bytes3"
      },
      {
        "name": "_price",
        "type": "uint256"
      },
      {
        "name": "_owner",
        "type": "address"
      },
      {
        "name": "_cType",
        "type": "uint256"
      },
      {
        "name": "_alliance",
        "type": "uint256"
      },
      {
        "name": "_attacks",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_limit",
        "type": "uint256"
      }
    ],
    "name": "UpdateWarpoolLimit",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetWarpoolLimit",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "ProtectedStateSwitch",
    "outputs": [
      {
        "name": "switched",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "ReadyToSwitch",
    "outputs": [
      {
        "name": "ready",
        "type": "bool"
      },
      {
        "name": "valueleft",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "SwitchState",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_state",
        "type": "uint256"
      }
    ],
    "name": "ownedSetWorldState",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetWorldState",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_owner",
        "type": "address"
      }
    ],
    "name": "GetUserCountries",
    "outputs": [
      {
        "name": "",
        "type": "bytes3[]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      },
      {
        "name": "_cType",
        "type": "uint256"
      },
      {
        "name": "_parentCode",
        "type": "bytes3"
      },
      {
        "name": "_owner",
        "type": "address"
      },
      {
        "name": "_pr",
        "type": "uint256"
      }
    ],
    "name": "Mint",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "MintDefaultCountries",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetCountriesCount",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_bytes3",
        "type": "bytes3"
      }
    ],
    "name": "bytes3ToStr",
    "outputs": [
      {
        "name": "",
        "type": "string"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      }
    ],
    "name": "GetCountryPrice",
    "outputs": [
      {
        "name": "price",
        "type": "uint256"
      },
      {
        "name": "country",
        "type": "bytes3"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetCountries",
    "outputs": [
      {
        "name": "",
        "type": "bytes3[]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      }
    ],
    "name": "GetCountryOwner",
    "outputs": [
      {
        "name": "",
        "type": "address"
      },
      {
        "name": "",
        "type": "string"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetBalance",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      }
    ],
    "name": "BuyCountry",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      },
      {
        "name": "_dType",
        "type": "uint256"
      }
    ],
    "name": "BuyDefense",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_state",
        "type": "uint256"
      },
      {
        "name": "_days",
        "type": "uint256"
      },
      {
        "name": "_hours",
        "type": "uint256"
      }
    ],
    "name": "SetStateTime",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetStateTimers",
    "outputs": [
      {
        "name": "pd",
        "type": "uint256"
      },
      {
        "name": "ph",
        "type": "uint256"
      },
      {
        "name": "ad",
        "type": "uint256"
      },
      {
        "name": "ah",
        "type": "uint256"
      },
      {
        "name": "wd",
        "type": "uint256"
      },
      {
        "name": "wh",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetPhaseTimers",
    "outputs": [
      {
        "name": "phase",
        "type": "uint256"
      },
      {
        "name": "start",
        "type": "uint256"
      },
      {
        "name": "end",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      }
    ],
    "name": "GetCountryDefenses",
    "outputs": [
      {
        "name": "ccode",
        "type": "bytes3"
      },
      {
        "name": "d1",
        "type": "bool"
      },
      {
        "name": "d5",
        "type": "bool"
      },
      {
        "name": "d15",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      },
      {
        "name": "_aPer",
        "type": "uint256"
      }
    ],
    "name": "AttackCountry",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": true,
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_owner",
        "type": "address"
      }
    ],
    "name": "UserBalance",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_user",
        "type": "address"
      }
    ],
    "name": "UserCountries",
    "outputs": [
      {
        "name": "",
        "type": "bytes3[]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_owner",
        "type": "address"
      }
    ],
    "name": "OwnCountry",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_alliance",
        "type": "uint256"
      }
    ],
    "name": "GetAllianceValue",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_alliance",
        "type": "uint256"
      }
    ],
    "name": "GetAllianceScore",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetAllowedAlliances",
    "outputs": [
      {
        "name": "_a1Allowed",
        "type": "bool"
      },
      {
        "name": "_a2Allowed",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [],
    "name": "SetAllowedAlliances",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      },
      {
        "name": "",
        "type": "bool"
      },
      {
        "name": "",
        "type": "uint256"
      },
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "alliance",
        "type": "uint256"
      }
    ],
    "name": "SetAlliance",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_user",
        "type": "address"
      }
    ],
    "name": "ChangeAlliance",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "_CR",
        "type": "bytes3"
      }
    ],
    "name": "GetCountryAlliance",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      },
      {
        "name": "",
        "type": "string"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "GetMyAlliance",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  }
]
