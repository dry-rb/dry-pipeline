# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dry/pipeline/version'

Gem::Specification.new do |spec|
  spec.name          = "dry-pipeline"
  spec.version       = Dry::Pipeline::VERSION.dup
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]

  spec.summary       = 'Pipeline operator for callable objects'
  spec.homepage      = 'https://github.com/dryrb/dry-pipeline'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
