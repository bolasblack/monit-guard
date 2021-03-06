xml2js = require 'xml2js'
utils = require 'scripts/utils'
requestServer = require 'scripts/actions/request_server'
receiveServer = require 'scripts/actions/receive_server'
fetchFailed = require 'scripts/actions/fetch_failed'

boolProps = 'monitor ssl'.split(' ')
negateBoolProps = 'status'.split(' ')
numberProps = [
  # server
  'uptime poll startdelay port'
  # platform
  'cpu memory swap'
  # service common
  'collected_sec collected_usec monitormode pendingaction'
  # service process 3
  'pid ppid uid euid gid children kilobyte kilobytetotal'
  # service host 4
  ''
  # service filesystem 0
  'uid gid'
  # service system
  ''
].join(' ').split /\s+/

transformOrPickHead = (obj, key) ->
  obj = R.head obj if Array.isArray obj
  servicePropTransform obj, key

servicePropTransform = (obj, key) ->
  R.ifElse(
    R.isObject,
    R.ifElse(Array.isArray, R.map(transformOrPickHead), R.mapObjIndexed(transformOrPickHead))
    R.curryN(2, R.cond([
      [R.isNil                          , R.always(obj)]
      [R.containedBy(boolProps)         , R.pipe R.always(obj), Number, Boolean]
      [R.containedBy(negateBoolProps)   , R.pipe R.always(obj), Number, R.not]
      [R.containedBy(numberProps)       , R.pipe R.always(obj), Number]
      [R.T                              , R.always(obj)]
    ]))(key)
  )(obj)

filterByXMLAttr = (checker, xml) ->
  R.filter R.pipe(R.path(['$']), checker), xml

filterServiceByType = (type, server) ->
  filterByXMLAttr R.propEq('type', type.toString()), server.service

transformXML = (xmlString) ->
  Promise.promisify(xml2js.parseString)(xmlString).then (server) ->
    server = server.monit
    server.info        = servicePropTransform R.head(server.server), 'server'
    server.platform    = servicePropTransform R.head(server.platform), 'platform'
    server.system      = servicePropTransform R.head(filterServiceByType 5, server), 'system'
    server.hosts       = servicePropTransform filterServiceByType(4, server), 'hosts'
    server.processes   = servicePropTransform filterServiceByType(3, server), 'processes'
    server.filesystems = servicePropTransform filterServiceByType(0, server), 'filesystems'

    delete server.server
    delete server.service
    server

module.exports = fetchServer = (url) ->
  (dispatch) ->
    dispatch(requestServer url)
    fetch(utils.expandServerUrl url)
      .then (response) -> response.text()
      .then transformXML
      .then(
        (server) -> dispatch(receiveServer url, server)
        (server) -> dispatch(fetchFailed url, server)
      )

fetchServer.transformXML = transformXML
