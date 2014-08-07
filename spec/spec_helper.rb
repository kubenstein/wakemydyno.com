require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, 'http://test.com/', :body => 'ok')
FakeWeb.register_uri(:any, 'http://test.com/wakemydyno.txt', :body => 'ok')
FakeWeb.register_uri(:any, 'http://test2.com/wakemydyno.txt', :body => 'ok')
FakeWeb.register_uri(:any, 'http://nofile.com/wakemydyno.txt', :status => '404')
