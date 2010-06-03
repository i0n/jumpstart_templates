# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'PROJECT_NAME'
 
Gem::Specification.new do |s|
  s.name        = "PROJECT_NAME"
  s.version     = PROJECT_NAME.version
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ian Alexander Wood (i0n)"]
  s.email       = ["ianalexanderwood@gmail.com"]
  s.homepage    = "http://github.com/i0n/PROJECT_NAME"
  s.summary     = ""
  s.description = ""
  s.required_rubygems_version = ">= 1.3.6" 
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
  s.files        = Dir.glob("{bin,config,lib,test}/**/*") + %w(LICENSE Rakefile README.rdoc)
  s.executables  = ['PROJECT_NAME']
  s.require_path = 'lib'
end