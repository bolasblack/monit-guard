type = 'RECEIVE_SERVER'

updateServer = (url, server, state) ->
  R.replaceWhile R.merge(server, fetching: false, url: url), R.propEq('url', url), state.servers

module.exports = receiveServer = (url, server) ->
  {type, url, server}

receiveServer.type = type
receiveServer.reducer = (state, action) ->
  R.assoc 'servers', updateServer(action.url, action.server, state), state
