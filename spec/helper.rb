$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'postly'

SAMPLE_CONFIG = File.open(File.dirname(__FILE__) + '/postly.yml')
SAMPLE_IMAGE  = File.open(File.dirname(__FILE__) + '/fixtures/metal.png')
Postly.config = SAMPLE_CONFIG

RSpec.configure do |config|
end

