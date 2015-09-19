window.R = require 'ramda'
window.moment = require 'moment'
window.Promise = require 'bluebird'
window.React = require 'react/addons'
require 'whatwg-fetch'
require 'src/utils/ramda'

# @if DEBUG
global.__DEBUG__ = true
# @endif
# @if DEV
global.__DEV__ = true
# @endif
# @if PROD
global.__PROD__ = true
# @endif
