# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/time_scope/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-time-scope"
  spec.version       = ActiveRecord::TimeScope::VERSION
  spec.authors       = ["Daisuke Taniwaki", "Alexey Chernenkov"]
  spec.email         = ["daisuketaniwaki@gmail.com", "laise@pisem.net"]
  spec.summary       = "Date/time scopes for ActiveRecord"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/907th/activerecord-time-scope"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "activerecord", ">= 4.0"
end
