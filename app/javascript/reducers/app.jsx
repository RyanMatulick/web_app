const responseTypes = [
  'receive', 'response', 'error', 'success'
]

const initialState = { pendingRequests: [] }
export default (state = initialState, action) => {
  const { pendingRequests } = state
  var type = action.type.toLowerCase()
  var requests = state.pendingRequests.slice()

  if (type.indexOf('request') >= 0) {
    requests.push(type)
  } else {    
    var requestType = type
    responseTypes.forEach(rt => {
      requestType = requestType.replace(rt, 'request')
    });
    
    var requestIndex = requests.findIndex(r => r === requestType)
    if (requestIndex >= 0) {
      requests.splice(requestIndex, 1)
    }
  }

  return { pendingRequests: requests }
};