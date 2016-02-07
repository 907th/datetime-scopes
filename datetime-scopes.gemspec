lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "datetime-scopes/version"

Gem::Specification.new do |spec|
  spec.name          = "datetime-scopes"
  spec.version       = DateTimeScopes::VERSION
  spec.authors       = ["Alexey Chernenkov"]
  spec.email         = ["laise@pisem.net"]
  spec.summary       = "Date/time scopes for ActiveRecord models you always missed!"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/907th/datetime-scopes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11.2"
  spec.add_development_dependency "rake", "~> 10.4.2"

  spec.add_dependency "activerecord", ">= 4.0"
  spec.add_dependency "activesupport", ">= 4.0"
end
