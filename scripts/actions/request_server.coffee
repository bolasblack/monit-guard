type = 'REQUEST_SERVER'

module.exports = requestServer = (url) ->
  {type, url}

requestServer.type = type
requestServer.reducer = (state, action) ->
  newServers = R.mapReplace(R.assoc('fetching', true), R.propEq('url', action.url), state.servers)
  R.assoc 'servers', newServers, state
