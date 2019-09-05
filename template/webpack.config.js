// webpack v4
const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const autoprefixer = require("autoprefixer");
const MinifyPlugin = require("babel-minify-webpack-plugin");

const extractMiniCss = new MiniCssExtractPlugin({
  filename: "stylesheets/[name].css"
});

module.exports = {
  entry: {
    application: './source/js/script.js',
    styles: './source/scss/style.scss',
  },
  resolve: {
    modules: [
      path.join(__dirname, 'source/scss'),
      path.join(__dirname, 'source/js'),
      "node_modules"
    ]
  },
  output: {
    path: path.resolve(__dirname, '.tmp/dist'),
    filename: 'javascripts/[name].js',
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      },
      {
        enforce: 'pre',
        test: /\.s[ac]ss/,
        use: 'import-glob-loader'
      },
      {
        test: /\.s[ac]ss$/,
        use: [
          { loader: MiniCssExtractPlugin.loader },
          { loader: "css-loader" },
          {
            loader: 'postcss-loader',
            options: {
              plugins: () => [autoprefixer()]
            }
          },
          { loader: "sass-loader" }
        ]
      }
    ]
  },
  plugins: [
    extractMiniCss,
    new MinifyPlugin()
  ]
};
