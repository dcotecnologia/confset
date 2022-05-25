# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

require "config/version"

Gem::Specification.new do |s|
  s.name             = "config"
  s.version          = Config::VERSION
  s.date             = Time.now.strftime "%F"
  s.authors          = ["Piotr Kuczynski", "Fred Wu", "Jacques Crocker", "Danilo Carolino"]
  s.email            = %w[danilogcarolino@gmail.com]
  s.summary          = "Effortless multi-environment settings in Rails, Sinatra, Pandrino and others"
  s.description      = "Easiest way to manage multi-environment settings in any ruby project or framework: " +
                       "Rails, Sinatra, Pandrino and others"
  s.homepage         = "https://github.com/rubyconfig/config"
  s.license          = "MIT"
  s.extra_rdoc_files = %w[README.md CHANGELOG.md CONTRIBUTING.md LICENSE.md]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.files = `git ls-files`.split($/)
  s.files.select! { |file| /(^lib\/|^\w+.md$|\.gemspec$)/ =~ file }
  s.require_paths         = ["lib"]
  s.required_ruby_version = ">= 2.7.0"
  s.add_dependency "deep_merge", "~> 1.2", ">= 1.2.1"
  s.add_dependency "dry-validation", "~> 1.0", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 3.9", ">= 3.9.0"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "simplecov", "~> 0.21"
  s.add_development_dependency "mdl", "~> 0.11"
  s.add_development_dependency "rubocop", "~> 1.29"
  s.add_development_dependency "rubocop-packaging", "~> 0.5"
  s.add_development_dependency "rubocop-performance", "~> 1.14"
end
