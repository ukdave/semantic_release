# frozen_string_literal: true

require_relative "semantic_release/semver"
require_relative "semantic_release/version"
Dir[File.join(__dir__, "semantic_release", "updaters", "*.rb")].each { |file| require file }

module SemanticRelease
  class Error < StandardError; end

  SEMVER_FILE = ".semver"
end
