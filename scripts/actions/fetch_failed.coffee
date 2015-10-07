scheduleFetch = require 'src/actions/schedule_fetch'
type = 'FETCH_FAILED'

updateServer = (url, server, state) ->
  R.mapReplace R.always(R.merge server, fetching: false, fetch_failed: true, url: url), R.propEq('url', url), state.servers

module.exports = fetchFailed = (url, server) ->
  (dispatch) ->
    scheduleFetch dispatch, url
    dispatch {type, url, server}

fetchFailed.type = type
fetchFailed.reducer = (state, action) ->
  R.assoc 'servers', updateServer(action.url, action.server, state), state
