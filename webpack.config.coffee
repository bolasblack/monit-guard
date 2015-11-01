_ = require 'lodash'
sysPath = require 'path'
webpack = require 'webpack'

preprocessContext = {
  PROD: process.env.NODE_ENV is 'production'
  DEV: process.env.NODE_ENV not in 'production test'.split(' ')
  TEST: process.env.NODE_ENV is 'test'
}

config = {
  entry: [
    './scripts/index'
  ]
  resolveLoader:
    modulesDirectories: ['node_modules']
  resolve:
    extensions: ['', '.js', '.coffee', '.sass']
  module:
    loaders: [
      {test: /\.css$/, loader: 'style!css'}
      {test: /\.sass$/, loader: 'style!css!sass?indentedSyntax'}
      {test: /\.coffee$/, loader: "coffee-jsx!preprocess?#{JSON.stringify preprocessContext}"}
    ]
  output:
    path: sysPath.join(__dirname, "public")
    filename: '[name].js'
}

if preprocessContext.DEV
  config = _.extend {
    devtool: ['source-map']
    watch: true
    debug: true
    plugins: [
      new webpack.HotModuleReplacementPlugin()
    ]
  }, config
  config.entry.unshift "webpack-dev-server/client?http://127.0.0.1:9090", "webpack/hot/dev-server"
else
  config = _.extend {
    devtool: ['source-map']
  }, config

module.exports = config
