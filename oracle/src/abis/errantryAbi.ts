export const errantryAbi = [
  {
    inputs: [
      {
        internalType: "contract IEntryPoint",
        name: "_entry_point",
        type: "address",
      },
      {
        internalType: "address",
        name: "_trusted_oracle",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "ClientAlreadyRegistered",
    type: "error",
  },
  {
    inputs: [],
    name: "OnlyTrustedOracle",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "client",
        type: "address",
      },
    ],
    name: "ClientRegistered",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
    ],
    name: "cancelErrand",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
    ],
    name: "getErrandManagerAddress",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
    ],
    name: "isClientRegistered",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
    ],
    name: "markErrandAsComplete",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
    ],
    name: "markErrandAsPaid",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        components: [
          {
            internalType: "address",
            name: "client",
            type: "address",
          },
          {
            internalType: "uint256",
            name: "expires",
            type: "uint256",
          },
          {
            internalType: "address",
            name: "tokenAddress",
            type: "address",
          },
          {
            internalType: "uint256",
            name: "amount",
            type: "uint256",
          },
        ],
        internalType: "struct IErrantry.PostNewErrandParams",
        name: "params",
        type: "tuple",
      },
    ],
    name: "postNewErrand",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
    ],
    name: "registerNewClient",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        internalType: "address",
        name: "clientAddress",
        type: "address",
      },
      {
        internalType: "address",
        name: "runner",
        type: "address",
      },
    ],
    name: "updateErrandRunner",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const
