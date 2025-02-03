# frozen_string_literal: true

module SemanticRelease
  class Configuration
    attr_accessor :semver_file

    def initialize
      @semver_file = ".semver"
    end
  end
end
