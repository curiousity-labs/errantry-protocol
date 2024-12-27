import { useCallback, useEffect, useReducer } from "react"

enum ErrantryActionType {
  SET_CLIENT_STATUS = "SET_CLIENT_STATUS",
  SET_ORACLE_STATUS = "SET_ORACLE_STATUS",
  SET_CURRENT_ERRANDS = "SET_CURRENT_ERRANDS",
}

type ErrantryProtocolState = {
  isConnectedAddressRegistered: boolean
  isErrantryOracleConnected: boolean
  isErrantryOracleOnline: boolean
  currentErrands: string[] // Replace string[] with the actual type for errands
  // Future feature
  // errandHistory: Errand[]; // Uncomment and define `Errand` type as needed
}

type Action =
  | {
      type: ErrantryActionType.SET_CLIENT_STATUS
      payload: { isConnectedAddressRegistered: boolean }
    }
  | {
      type: ErrantryActionType.SET_ORACLE_STATUS
      payload: { isErrantryOracleConnected: boolean; isErrantryOracleOnline: boolean }
    }
  | { type: ErrantryActionType.SET_CURRENT_ERRANDS; payload: { currentErrands: string[] } }

function reducer(state: ErrantryProtocolState, action: Action): ErrantryProtocolState {
  switch (action.type) {
    case ErrantryActionType.SET_CLIENT_STATUS:
      return { ...state, isConnectedAddressRegistered: action.payload.isConnectedAddressRegistered }
    case ErrantryActionType.SET_ORACLE_STATUS:
      return {
        ...state,
        isErrantryOracleConnected: action.payload.isErrantryOracleConnected,
        isErrantryOracleOnline: action.payload.isErrantryOracleOnline,
      }
    case ErrantryActionType.SET_CURRENT_ERRANDS:
      return { ...state, currentErrands: action.payload.currentErrands }
    default:
      throw new Error(`Unhandled action type: ${action}`)
  }
}

const initialState: ErrantryProtocolState = {
  isConnectedAddressRegistered: false,
  isErrantryOracleConnected: false,
  isErrantryOracleOnline: false,
  currentErrands: [],
  // Future feature
  // errandHistory: [],
}

async function fetchClientStatus(): Promise<boolean> {
  return true
}

async function fetchOracleStatus(): Promise<[boolean, boolean]> {
  return [true, true]
}

async function fetchCurrentErrands(): Promise<string[]> {
  return ["Errand 1", "Errand 2"]
}

export default function useErrantryProtocol() {
  const [state, dispatch] = useReducer(reducer, initialState)

  const getErrantryClientStatus = useCallback(async () => {
    const isRegistered = await fetchClientStatus()
    dispatch({
      type: ErrantryActionType.SET_CLIENT_STATUS,
      payload: { isConnectedAddressRegistered: isRegistered },
    })
  }, [])

  const getErrantryOracleStatus = useCallback(async () => {
    const [isConnected, isOnline] = await fetchOracleStatus()
    dispatch({
      type: ErrantryActionType.SET_ORACLE_STATUS,
      payload: { isErrantryOracleConnected: isConnected, isErrantryOracleOnline: isOnline },
    })
  }, [])

  const getErrantryOracleClientData = useCallback(async () => {
    const errands = await fetchCurrentErrands()
    dispatch({ type: ErrantryActionType.SET_CURRENT_ERRANDS, payload: { currentErrands: errands } })
  }, [])

  useEffect(() => {
    getErrantryClientStatus()
    getErrantryOracleStatus()
    getErrantryOracleClientData()
  }, [getErrantryClientStatus, getErrantryOracleStatus, getErrantryOracleClientData])

  return state
}
