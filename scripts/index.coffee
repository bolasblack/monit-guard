require 'scripts/vendor'
{Provider} = require 'react-redux'
ReactDOM = require 'react-dom'
newStore = require 'scripts/store'
App = require 'scripts/app'
store = newStore()

# @if DEV
DevTools = require 'scripts/DevTools'
ReactDOM.render(
  <div>
    <Provider store={store}>
      <div>
        <App />
        <DevTools />
      </div>
    </Provider>
  </div>
  document.getElementById('app')
)
# @endif
# @if PROD
ReactDOM.render(
  <div>
    <Provider store={store}>
      <App />
    </Provider>
  </div>
  document.getElementById('app')
)
# @endif
