# frozen_string_literal: true

require_relative "semantic_release/semver"
require_relative "semantic_release/version"
Dir[File.join(__dir__, "semantic_release", "updaters", "*.rb")].each { |file| require file }

module SemanticRelease
  class Error < StandardError; end

  SEMVER_FILE = ".semver"

  def self.init
    version = Semver.new
    version.save(SEMVER_FILE)
  end

  def self.current_version
    Semver.load(SEMVER_FILE).to_s
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
    version = Semver.load(SEMVER_FILE)
    version.increment(term)
    version.save
  end

  def self.release
    Updaters::Changelog.update
    Updaters::VersionRb.update
    Updaters::GitTag.update
  end
end
