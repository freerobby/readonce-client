# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'readonce/version'

Gem::Specification.new do |spec|
  spec.name          = "readonce"
  spec.version       = Readonce::VERSION
  spec.authors       = ["Robby Grossman"]
  spec.email         = ["robby@freerobby.com"]

  spec.summary       = %q{Creates readonce entries.}
  spec.description   = %q{Creates readonce entries and provides a token URL.}
  spec.homepage      = "http://readonce-production.heroku.com."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '~> 0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'fakeweb', '~> 1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'vcr', '~> 3'
end
