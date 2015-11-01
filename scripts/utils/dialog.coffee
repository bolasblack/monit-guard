
module.exports = 'alert confirm prompt'.split(' ').reduce (memo, method) ->
  memo[method] = (args...) ->
    new Promise (resolve, reject) ->
      resolve window[method] args...
  memo
, {}
