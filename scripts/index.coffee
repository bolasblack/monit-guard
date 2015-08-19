require 'app/vendor'
{Provider} = require 'react-redux'
newStore = require 'app/store'
App = require 'app/app'
store = newStore()

# @if DEBUG
{DevTools, DebugPanel, LogMonitor} = require 'redux-devtools/lib/react'
React.render(
  <div>
    <Provider store={store}>
      {-> <App />}
    </Provider>
    <DebugPanel top right bottom>
      <DevTools store={store} monitor={LogMonitor} />
    </DebugPanel>
  </div>
  document.getElementById('app')
)
# @endif
# @if !DEBUG
React.render(
  <div>
    <Provider store={store}>
      {-> <App />}
    </Provider>
  </div>
  document.getElementById('app')
)
# @endif
