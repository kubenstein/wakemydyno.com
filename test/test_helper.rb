require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, 'http://test.com/', :body => 'ok')
FakeWeb.register_uri(:any, 'http://test.com/wakemydyno.txt', :body => 'ok')
FakeWeb.register_uri(:any, 'http://nofile.com/wakemydyno.txt', :status => '404')