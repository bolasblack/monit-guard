utils = require 'app/utils'
type = 'REMOVE_SERVER'

module.exports = removeServer = (url) ->
  {type, url}

removeServer.type = type
removeServer.reducer = (state, action) ->
  state = R.assocDrop 'servers', R.propEq('url', action.url), state
  utils.storage().set 'urls', R.pluck 'url', state.servers
  state
