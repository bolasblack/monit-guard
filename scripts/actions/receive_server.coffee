scheduleFetch = require 'app/actions/schedule_fetch'
type = 'RECEIVE_SERVER'

updateServer = (url, server, state) ->
  R.mapReplace R.always(R.merge server, fetching: false, url: url), R.propEq('url', url), state.servers

module.exports = receiveServer = (url, server) ->
  (dispatch) ->
    scheduleFetch dispatch, url
    dispatch {type, url, server}

receiveServer.type = type
receiveServer.reducer = (state, action) ->
  R.assoc 'servers', updateServer(action.url, action.server, state), state
