# -*- encoding : utf-8 -*-
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE']) # Set up gems listed in the Gemfile.
