# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "posterous/version"

Gem::Specification.new do |s|
  s.name        = "posterous"
  s.version     = Posterous::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Burnett @twoism"]
  s.email       = ["signalstatic@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/posterous"
  s.summary     = %q{Ruby wrapper for the Posterous REST API}
  s.description = %q{Ruby wrapper for the Posterous REST API v2}

  s.rubyforge_project = "posterous"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'typhoeus'
  s.add_dependency 'json'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ZenTest'
  s.add_development_dependency 'autotest-growl'
  s.add_development_dependency 'autotest-fsevent'
end
