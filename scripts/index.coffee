require 'app/vendor'
{Provider} = require 'react-redux'
{DevTools, DebugPanel, LogMonitor} = require 'redux-devtools/lib/react'
newStore = require 'app/store'
App = require 'app/app'
store = newStore()

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
