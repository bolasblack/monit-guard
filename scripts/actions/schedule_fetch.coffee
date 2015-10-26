
module.exports = (dispatch, url) ->
  console.log 'schedule fetch', url
  fetchServer = require 'scripts/actions/fetch_server'
  setTimeout (-> dispatch fetchServer url), 1000 * 30
