source 'https://rubygems.org'

ruby '2.5.1'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.18'
#gem 'mysql2', '>= 0.4.4', '< 0.6.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

gem 'bootsnap'
#FROM DC

source 'http://gems.gemfury.com/fHtphqCq9zLeDRvssKD4/'

gem 'rails', '~> 4.2'
gem 'protected_attributes'
gem 'rack-ssl'
gem 'rake'

# Internationalisation
gem 'rails-i18n', '~> 4.0'
gem 'iso_country_codes'
gem 'money-rails'

# HTTP server
gem 'unicorn'

# EngineYard
gem 'ey_config'
gem 'ey-provisioner'

# HTTP Client
gem "excon"

# Performance
gem 'scout_apm'

# API
gem 'grape'
gem 'grape-entity'

gem 'rabl'
gem 'oj'
gem 'versioncake'

# Strip invalid utf-8 chars from requests
gem 'utf8-cleaner'

# Date Picker
gem 'jquery-rails', '~> 2.1.4'

# JS Date library
gem 'momentjs-rails'

gem 'state_machine'

gem 'addressable'

gem 'paper_trail'

gem 'aws-sdk', '< 2.0'

gem 'rest-client'

group :console do
  # Better `print`
  gem 'awesome_print', require: 'ap'

  # Syntax highlighting
  gem 'wirb'

  # Custom views for specific objects, e.g. tables for ActiveRecord
  gem 'hirb-unicode'
  gem 'hirb-colors'
end

# Models
gem 'pg', '~> 0.20.0'
gem "squeel", '~> 1.2.3'
gem 'ransack'
gem 'ancestry'
gem "nickel"
gem 'activerecord-import'
gem 'settingcrazy', '~> 0.1.11', git: 'https://github.com/echannel/settingcrazy.git'
gem "acts_as_list", '~> 0.6.0'
gem 'validates_timeliness'
gem "active_model_serializers"
gem 'redlock'

# These required for seeds so is used in production (for staging/develop)
gem 'machinist'
gem 'sham'
gem 'forgery'

# Controllers
gem 'inherited_resources'

# Views
gem 'browser'
gem 'haml', "~> 4.0.6"
gem 'haml-rails'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'dotiw'
gem 'navigasmic'
gem 'react-rails'

# Authentication and authorisation
gem 'devise'
gem 'devise_invitable'
gem 'cancan'

# omniauth
gem 'omniauth-google-oauth2'
# Encoding
gem 'magic_encoding'

# Images
gem 'gravtastic'

# Worker
gem 'nokogiri'
gem 'savon'
gem "httparty"
gem 'resque'

# Vendor Specific

gem "google-api-client"

# We shouldn't need to include this as it is a dependency of google-api-client...
#
# However, when we run: bundle install --deployment --without test development
# with this gem defined in the :development, :test block
# the app does not start as the gem is not installed
gem "launchy", "~> 2.3.0"

# Documentation
gem 'yard'

# Email
gem "aws-ses"

# SFTP (for Grays SFTP access)
gem "net-sftp"

# Data Migration
gem 'data_migrate'

# Inventory Filters
gem 'htmlentities'

# Decorators
gem 'draper'

# Application Config
gem "app"

# Error Capturing
gem "rollbar"
gem "resque-rollbar"


gem 'createsend'


# Gems used only for assets and not required
# in production environments by default.
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-datatables-rails', git: 'https://github.com/rweng/jquery-datatables-rails'

gem 'asset_sync'
gem 'handlebars_assets'

gem 'jira-ruby'

gem 'webpacker'

group :development, :test, :staging do
  # Fixtures
  gem 'database_cleaner'
end

group :development do
  gem "better_errors"
  gem "quiet_assets"
  gem "binding_of_caller"
  gem "thin"
  gem 'meta_request'
  gem 'rb-fsevent',       require: false
  # Better logging
  gem 'sql-logging'
  gem 'foreman'
end

# Testing
group :development, :test do
  # Rspec
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'shoulda'
  gem 'test-unit'

  gem "factory_bot_rails", require: false

  #gem 'capybara'
  #gem 'capybara-webkit'
  #gem 'capybara-firebug'
  #gem 'selenium-webdriver'

  gem 'poltergeist'

  # Jasmine
  gem 'jasmine'
  gem 'guard-jasmine'
  gem 'jasmine-jquery-rails'

  # Mocking
  gem "mocha", :require => "mocha/setup"

  # Helpers
  gem 'timecop'
  gem 'timer'
  gem "rspec-xml"
  gem 'equivalent-xml'

  gem 'pry'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'sham_rack'

  # Fake mail for development
  gem 'mailtrap'

  gem "ruby-debug-ide"
  gem "debase"
  gem "rubocop"
  gem 'spring'
  gem 'spring-commands-rspec'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do

  # Coverage Testing in the cloud :p
  gem "codeclimate-test-reporter"
  gem 'simplecov-json'

  gem 'resque_spec'
  gem 'grape-entity-matchers'

  # VCR Mocks
  gem "vcr"
  gem "webmock"
end
