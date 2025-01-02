export const errandManagerAbi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "clientSmartAccount",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "ErrandAlreadyCancelled",
    type: "error",
  },
  {
    inputs: [],
    name: "ErrandAlreadyCompleted",
    type: "error",
  },
  {
    inputs: [],
    name: "ErrandAlreadyPaid",
    type: "error",
  },
  {
    inputs: [],
    name: "ErrandNotCompleted",
    type: "error",
  },
  {
    inputs: [],
    name: "ErrandNotPaid",
    type: "error",
  },
  {
    inputs: [],
    name: "MustBeClientSmartAccount",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
    ],
    name: "OwnableInvalidOwner",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "OwnableUnauthorizedAccount",
    type: "error",
  },
  {
    inputs: [],
    name: "ReentrancyGuardReentrantCall",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
    ],
    name: "ErrandCancelled",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
    ],
    name: "ErrandCompleted",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
    ],
    name: "ErrandPaid",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        indexed: true,
        internalType: "address",
        name: "client",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "runner",
        type: "address",
      },
      {
        indexed: false,
        internalType: "address",
        name: "paymentToken",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "paymentAmount",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "expires",
        type: "uint256",
      },
    ],
    name: "ErrandPosted",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        indexed: true,
        internalType: "address",
        name: "runner",
        type: "address",
      },
    ],
    name: "ErrandRunnerUpdated",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "previousOwner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "OwnershipTransferred",
    type: "event",
  },
  {
    inputs: [],
    name: "CLIENT_SMART_ACCOUNT_ADDRESS",
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
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
    ],
    name: "cancelErrand",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "errandCount",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "errands",
    outputs: [
      {
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
      {
        components: [
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
        internalType: "struct IErrandManager.PaymentToken",
        name: "paymentToken",
        type: "tuple",
      },
      {
        internalType: "address",
        name: "runner",
        type: "address",
      },
      {
        internalType: "uint8",
        name: "status",
        type: "uint8",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getClientSmartAccountAddress",
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
        internalType: "uint256",
        name: "errandId",
        type: "uint256",
      },
    ],
    name: "getErrand",
    outputs: [
      {
        components: [
          {
            internalType: "uint256",
            name: "errandId",
            type: "uint256",
          },
          {
            components: [
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
            internalType: "struct IErrandManager.PaymentToken",
            name: "paymentToken",
            type: "tuple",
          },
          {
            internalType: "address",
            name: "runner",
            type: "address",
          },
          {
            internalType: "uint8",
            name: "status",
            type: "uint8",
          },
        ],
        internalType: "struct IErrandManager.Errand",
        name: "",
        type: "tuple",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getUnPaidErrands",
    outputs: [
      {
        components: [
          {
            internalType: "uint256",
            name: "errandId",
            type: "uint256",
          },
          {
            components: [
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
            internalType: "struct IErrandManager.PaymentToken",
            name: "paymentToken",
            type: "tuple",
          },
          {
            internalType: "address",
            name: "runner",
            type: "address",
          },
          {
            internalType: "uint8",
            name: "status",
            type: "uint8",
          },
        ],
        internalType: "struct IErrandManager.Errand[]",
        name: "",
        type: "tuple[]",
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
    ],
    name: "markErrandAsPaid",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "owner",
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
    name: "postNewErrand",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "renounceOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "transferOwnership",
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
