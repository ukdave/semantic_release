# frozen_string_literal: true

require_relative "semantic_release/configuration"
require_relative "semantic_release/semver"
require_relative "semantic_release/version"
Dir[File.join(__dir__, "semantic_release", "updaters", "*.rb")].each { |file| require file }

module SemanticRelease
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.init
    raise Error, "#{configuration.semver_file} already exists" if File.exist?(configuration.semver_file)

    version = Semver.new
    version.save(configuration.semver_file)
  end

  def self.current_version
    Semver.load(configuration.semver_file).to_s
  end

  def self.inc_major
    increment(:major)
    release
  end

  def self.inc_minor
    increment(:minor)
    release
  end

  def self.inc_patch
    increment(:patch)
    release
  end

  def self.increment(term)
    version = Semver.load(configuration.semver_file)
    version.increment(term)
    version.save
  end

  def self.release
    Updaters::Changelog.update
    Updaters::VersionRb.update
    Updaters::GemfileLock.update
    Updaters::GitTag.update
  end
end
