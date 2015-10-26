
actions = require 'scripts/actions'

module.exports = (state, triggeredAction) ->
  resultState = state
  R.mapObj (action) ->
    return if action.type isnt triggeredAction.type
    return if typeof action.reducer isnt 'function'
    resultState = action.reducer state, triggeredAction
  , actions
  resultState
