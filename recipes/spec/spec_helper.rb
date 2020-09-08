# frozen_string_literal: true
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../config/environment.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { record: :once }
end

def vcr(name, &block)
  VCR.use_cassette(name, &block)
end

RSpec.configure { |c| c.include RSpecMixin }
