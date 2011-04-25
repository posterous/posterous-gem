$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'posterous'

SAMPLE_CONFIG = File.dirname(__FILE__) + '/posterous.yml'
SAMPLE_IMAGE  = File.open(File.dirname(__FILE__) + '/fixtures/metal.png')
Posterous.config = SAMPLE_CONFIG
include Posterous
RSpec.configure do |config|
  
end

