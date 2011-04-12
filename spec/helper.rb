$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'postly'

SAMPLE_CONFIG = File.read(File.dirname(__FILE__) + '/postly.yml')
