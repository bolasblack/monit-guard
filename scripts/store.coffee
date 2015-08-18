{createStore, applyMiddleware, compose} = require 'redux'
{devTools, persistState} = require 'redux-devtools'
thunkMiddleware = require 'redux-thunk'
utils = require 'app/utils'
reducer = require 'app/reducer'

defaultInitialState = do ->
  try
    urls = JSON.parse(localStorage.getItem 'urls') or []
  catch
    localStorage.removeItem 'urls'
    urls = []

  servers: urls.map (url) ->
    url: url
    fetching: true

createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
  devTools()
  persistState(window.location.href.match(/[?&]debug_session=([^&]+)\b/))
  createStore
)

module.exports = (initialState = defaultInitialState) ->
  createStoreWithMiddleware reducer, initialState

###
    info: # server
      id: null
      incarnation: null
      version: null
      uptime: null
      poll: null
      startdelay: null
      localhostname: null
      controlfile: null
      httpd:
        address: null
        port: null
        ssl: false
    platform:
      name: null
      release: null
      version: null
      machine: null
      cpu: null
      memory: null
      swap: null
    system: # type 5
      name: null
      system:
        load:
          avg01: null
          avg05: null
          avg15: null
        cpu:
          user: null
          system: null
          wait: null
        memory:
          percent: null
          kilobyte: null
        swap:
          percent: null
          kilobyte: null
    hosts: [{ # type 4
      name: null
      icmp:
        type: null
        responsetime: null
    }]
    processes: [{ # type 3
      name: null
      pid: null
      ppid: null
      uid: null
      euid: null
      gid: null
      uptime: null
      children: null
      memory:
        percent: null
        percenttotal: null
        kilobyte: null
        kilobytetotal: null
      cpu:
        percent: null
        percenttotal: null
    }]
    filesystems: [{ # type 0
      name: null
      mode: null
      uid: null
      gid: null
      flags: null
      block:
        percent: null
        usage: null
        total: null
      inode:
        percent: null
        usage: null
        total: null
    }]
###
###
service common:
  collected_sec: null
  collected_usec: null
  status: null
  status_hint: null
  monitor: null
  monitormode: null
  pendingaction: null
###
