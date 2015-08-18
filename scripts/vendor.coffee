window.R = require 'ramda'
window.moment = require 'moment'
window.Promise = require 'bluebird'
window.React = require 'react/addons'
require 'whatwg-fetch'

R.assocAppend = (key, value, obj) ->
  R.assoc key, R.append(obj[key], value), obj

R.assocDrop = (key, fn, obj) ->
  R.assoc key, R.dropWhile(fn, obj[key]), obj

R.forEachObj = (fn, obj) ->
  Object.keys(obj).forEach (key) ->
    fn? obj[key], key

R.isObject = (obj) ->
  typeof obj is 'object'

R.isFunction = (obj) ->
  typeof obj is 'function'

R.containedBy = R.curryN 2, (ary, obj) ->
  R.contains obj, ary

# ((a -> b) | b) -> (a -> Boolean) -> [a] -> [a]
R.replaceWhile = (replacement, checker, ary) ->
  R.reduce (memo, value) ->
    oldValue = R.always value
    newValue = R.ifElse(R.isFunction, R.identity, R.always)(replacement)
    memo.push R.ifElse(checker, newValue, oldValue)(value)
    memo
  , [], ary
