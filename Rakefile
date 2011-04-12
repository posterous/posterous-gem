require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
task :spec do
  RSpec::Core::RakeTask.new(:core) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rspec_opts = ['--backtrace']
  end
end

task :default => :spec
