# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

require "confset/version"

Gem::Specification.new do |s|
  s.name             = "confset"
  s.version          = Confset::VERSION
  s.date             = Time.now.strftime "%F"
  s.authors          = ["Danilo Carolino", "Piotr Kuczynski", "Fred Wu", "Jacques Crocker"]
  s.email            = %w[danilogcarolino@gmail.com]
  s.summary          = "Effortless multi-environment settings in Rails, Sinatra, Pandrino and others"
  s.description      = "Easiest way to manage multi-environment settings in any ruby project or framework: "
  + "Rails, Sinatra, Pandrino and others"
  s.homepage = "https://github.com/dcotecnologia/confset"
  s.required_ruby_version = ">= 2.7.0"
  s.files = Dir["{lib}/**/*"] + ["Rakefile", "CHANGELOG.md", "README.md", "LICENSE.md"]
  s.test_files = Dir["spec/**/*"]
  s.license          = "MIT"
  s.rdoc_options     = ["--charset=UTF-8"]

  s.add_dependency "deep_merge", "~> 1.2", ">= 1.2.1"
  s.add_dependency "dry-validation", "~> 1.0", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 3.9", ">= 3.9.0"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "simplecov", "~> 0.21"
  s.add_development_dependency "mdl", "~> 0.11"
  s.add_development_dependency "pry", "~> 0.14"
  s.add_development_dependency "rubocop", "~> 1.29"
  s.add_development_dependency "rubocop-packaging", "~> 0.5"
  s.add_development_dependency "rubocop-performance", "~> 1.14"
end