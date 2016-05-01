$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'readonce'
require 'fakeweb'
require 'vcr'

FakeWeb.allow_net_connect = false

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :fakeweb
end
