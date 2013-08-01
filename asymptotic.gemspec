# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asymptotic/version'

Gem::Specification.new do |spec|
  spec.name          = "asymptotic"
  spec.version       = Asymptotic::VERSION
  spec.authors       = ["Aaron Cronin"]
  spec.email         = ["cronin@include.cat"]
  spec.description   = %q{Toolkit for asymptotic analysis of functions}
  spec.summary       = %q{Toolkit for asymptotic analysis of functions}
  spec.homepage      = "https://github.com/cronin101/asymptotic.gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "colored"
  spec.add_dependency "peach"
  spec.add_dependency "gnuplot"
end
