# frozen_string_literal: true

module SemanticRelease
  module Updaters
    class VersionRb < BaseUpdater
      def self.update
        version_file = find_version_rb
        return unless version_file

        version_string = "VERSION = \"#{current_version}\""
        content = File.read(version_file).sub(/VERSION = .*$/, version_string)

        File.write(version_file, content)
        `git add #{version_file}`
      end

      def self.find_version_rb
        version_files = Dir.glob("lib{,/**/*}/version.rb")
        return nil unless version_files.size == 1

        version_files.first
      end
    end
  end
end
