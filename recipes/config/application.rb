# frozen_string_literal: true
require 'bundler'
require 'dotenv/load'

Bundler.require(:default, ENV.fetch('RACK_ENV', 'development'))