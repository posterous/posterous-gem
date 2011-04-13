$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'postly'
require 'vcr'
require 'webmock'

SAMPLE_CONFIG = File.open(File.dirname(__FILE__) + '/postly.yml')
SAMPLE_IMAGE  = File.open(File.dirname(__FILE__) + '/metal.png')
Postly.config = SAMPLE_CONFIG

VCR.config do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.stub_with :webmock
end


