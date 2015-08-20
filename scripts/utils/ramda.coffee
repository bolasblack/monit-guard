R = require 'ramda'

R.isObject = (obj) ->
  typeof obj is 'object'

R.isFunction = (obj) ->
  typeof obj is 'function'

R.containedBy = R.curryN 2, (ary, obj) ->
  R.contains obj, ary

R.assocAppend = (key, value, obj) ->
  R.assoc key, R.append(value, obj[key]), obj

R.assocDrop = (key, fn, obj) ->
  R.assoc key, R.reject(fn, obj[key]), obj

R.mapReplace = (replacer, predicate, ary) ->
  R.map R.ifElse(predicate, replacer, R.identity), ary
