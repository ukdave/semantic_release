# frozen_string_literal: true

module SemanticRelease
  class Configuration
    attr_accessor :semver_file, :disable_rubygems_message

    def initialize
      @semver_file = ".semver"
      @disable_rubygems_message = false
    end
  end
end
