# frozen_string_literal: true

require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new

require_relative "lib/semantic_release/rake_task"
SemanticRelease::RakeTask.new(:semver)

task default: %i[spec rubocop]
