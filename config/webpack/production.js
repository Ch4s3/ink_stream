const environment = require('./environment')
const webpack = require('webpack')
const UglifyJSPlugin = require('uglifyjs-webpack-plugin')

environment.plugins.set(
  'UglifyJs',
  new webpack.optimize.UglifyJsPlugin({
    sourceMap: true,
    comments: false, // remove comments
    compress: {
      conditionals: true,
      unused: true,
      dead_code: true, // big one--strip code that will never execute
      warnings: false, // good for prod apps so users can't peek behind curtain
      drop_debugger: true,
      conditionals: true,
      evaluate: true,
      // drop_console: true, // strips console statements
      sequences: true,
      booleans: true,
      pure_getters: true,
      loops: true,
    }
  })
)
module.exports = environment.toWebpackConfig()
