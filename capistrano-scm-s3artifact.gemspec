# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/scm/s3artifact/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-scm-s3artifact"
  spec.version       = Capistrano::Scm::S3artifact::VERSION
  spec.authors       = ["arwineap"]
  spec.email         = ["arwineap@gmail.com"]
  spec.summary       = %q{A s3artifact strategy for Capistrano 3 to deploy tarball.}
  spec.description   = %q{A s3artifact strategy for Capistrano 3 to deploy tarball.}
  spec.homepage      = "https://github.com/arwineap/capistrano-scm-s3artifact"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
