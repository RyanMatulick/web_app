# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Run in two terminal:
One:
./bin/webpack-dev-server

Two:
rails s


If There is already a server running remove it:
e.g. rm /mnt/e/Programming/repos/salvo_site/miracles/tmp/pids/server.pid

If Cannot connect to DB:
sudo /etc/init.d/mysql start


MIGHT NEED TO PUT BACK INTO WEBPACK

const path              = require('path');
const webpack           = require('webpack');
const htmlPlugin        = require('html-webpack-plugin');
const openBrowserPlugin = require('open-browser-webpack-plugin'); 
const dashboardPlugin   = require('webpack-dashboard/plugin');
const autoprefixer      = require('autoprefixer'); 

const extractSass = new ExtractTextPlugin({
  filename: '[name].[contenthash].css',
  disable: process.env.NODE_ENV === 'development'
});

const VENDOR_LIBS = [
  'react',
  'react-dom',
  'react-router',
  'react-router-dom'
];


const PATHS = {
  app: path.join(__dirname, 'src'),
  images:path.join(__dirname,'src/assets/'),
  build: path.join(__dirname, 'dist')
};

const options = {
  host:'localhost',
  port:'1234'
};

module.exports = {
  entry: {
      bundle: ['babel-polyfill', './src/index.js'],
      vendor: VENDOR_LIBS
  },
  output: {
      path: path.join(__dirname, 'build'),
      publicPath: '/',
      filename: '[name].[chunkhash].js'
  },
  module: {
      rules: [
          {
              test: /\.jsx?$/,
              loader: 'babel-loader',
              include: [path.resolve(__dirname, 'src')],
              query: {
                  plugins: ['transform-runtime'],
                  presets: ['es2015', 'stage-0', 'react']
              }
          },
          {
              test: /\.scss$/,
              use: ExtractTextPlugin.extract([
                  'css-loader',
                  'postcss-loader',
                  'sass-loader'
              ])
          },
          {
              test: /\.png$/,
              use: [
                  {
                      loader: 'url-loader',
                      options: { limit: 40000 }
                  },
                  {
                      loader: 'image-webpack-loader',
                      query: { bypassOnDebug: true }
                  }
              ]
          }
      ]
  },
  devServer: {
      historyApiFallback: true
  },
  plugins: [
      new webpack.optimize.CommonsChunkPlugin({
          names: ['vendor', 'manifest']
      }),
      new HtmlWebpackPlugin({
          template: 'src/index.html'
      }),
      new webpack.LoaderOptionsPlugin({
          options: {
              postcss: [autoprefixer]
          }
      }),
      extractSass
  ]
};