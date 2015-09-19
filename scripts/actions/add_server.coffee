utils = require 'src/utils'
type = 'ADD_SERVER'

module.exports = addServer = (url) ->
  {type, url: url.replace /\/$/, ''}

addServer.type = type
addServer.reducer = (state, action) ->
  state = R.assocAppend 'servers', url: action.url, fetching: true, state
  utils.storage().set 'urls', R.pluck 'url', state.servers
  state
