# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sandthorn_event_filter/version'

Gem::Specification.new do |spec|
  spec.name          = "sandthorn_event_filter"
  spec.version       = SandthornEventFilter::VERSION
  spec.authors       = ["Jesper Josefsson"]
  spec.email         = ["jesper.josefsson@gmail.com"]
  spec.summary       = %q{Composable filters for Sandthorn Events}
  spec.homepage      = "https://github.com/Sandthorn"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # added by upptec_create_gem
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "gem-release"
  spec.add_development_dependency "autotest-standalone"
  spec.add_development_dependency "dotenv"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.add_runtime_dependency "hamster", "~>1.0"

end
