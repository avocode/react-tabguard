webpack = require 'webpack'

module.exports =
  entry: [
      'webpack-dev-server/client?http://localhost:8080'
      'webpack/hot/dev-server'
      "#{__dirname}/example/main.coffee"
  ]
  devtool: 'inline-source-map'
  debug: true
  output:
    path: "#{__dirname}/dist"
    filename: 'index.js'
  resolve:
    extensions: ['', '.coffee', '.js']
  resolveLoader:
    modulesDirectories: ['node_modules']
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ]
  module:
    loaders: [
      {
        test: /\.coffee$/
        loader: 'coffee'
      }
    ]
    noParse: /\.min\.js/
