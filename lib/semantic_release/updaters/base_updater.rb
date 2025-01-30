# frozen_string_literal: true

module SemanticRelease
  module Updaters
    class BaseUpdater
      def self.update
        raise "Not implemented"
      end

      def self.current_version
        Semver.load(semver_file).to_s
      end

      def self.semver_file
        SemanticRelease::SEMVER_FILE
      end
    end
  end
end
