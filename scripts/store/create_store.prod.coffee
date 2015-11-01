{createStore, applyMiddleware, compose} = require 'redux'
thunkMiddleware = require 'redux-thunk'

module.exports = createStoreWithMiddleware = compose(
  applyMiddleware(thunkMiddleware)
)(createStore)
