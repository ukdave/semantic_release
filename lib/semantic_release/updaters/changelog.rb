# frozen_string_literal: true

module SemanticRelease
  module Updaters
    class Changelog < BaseUpdater
      FILES = %w[CHANGELOG.md history.rdoc].freeze

      def self.update
        FILES.each do |file|
          next unless File.exist?(file)

          prepend_version(file)
          `git add #{file}`
        end
      end

      def self.prepend_version(filepath)
        heading_marker = filepath.end_with?(".rdoc") ? "==" : "##"
        content = File.read(filepath)
        File.open(filepath, "w") do |f|
          f.puts("#{heading_marker} #{current_version} (#{Time.now.strftime("%d %B %Y")})\n\n")
          f.print(content)
        end
      end
    end
  end
end
