{createDevTools} = require 'redux-devtools'
LogMonitor = require 'redux-devtools-log-monitor'
DockMonitor = require 'redux-devtools-dock-monitor'

module.exports = createDevTools(
  <DockMonitor toggleVisibilityKey='H' changePositionKey='Q'>
    <LogMonitor />
  </DockMonitor>
)
