#!/usr/bin/env rake
# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

Bundler::GemHelper.install_tasks

begin
  require "rake/testtask"
  require "rubocop/rake_task"

  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ["--display-cop-names"]
  end
rescue LoadError
  # no rspec available
end

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  # no rspec available
end

# Documentation
require "rdoc/task"

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title    = "Config #{Config::VERSION}"
  rdoc.options << "--line-numbers"
  rdoc.rdoc_files.include("README.*")
  rdoc.rdoc_files.include("CHANGELOG.*")
  rdoc.rdoc_files.include("LICENSE.*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

task default: %i[rubocop spec]
