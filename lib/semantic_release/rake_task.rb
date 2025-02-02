# frozen_string_literal: true

require "rake/tasklib"
require "semantic_release"

module SemanticRelease
  class RakeTask < Rake::TaskLib
    # rubocop:disable Metrics/MethodLength
    def initialize
      super

      namespace :semantic_release do
        desc "Initialise version file"
        task :init do
          SemanticRelease.init
        end

        desc "Display current version"
        task :current do
          puts SemanticRelease.current_version
        end

        desc "Increment major version (e.g. 1.2.3 => 2.0.0)"
        task :major do
          SemanticRelease.inc_major
        end

        desc "Increment minor version (e.g. 1.2.3 => 1.3.0)"
        task :minor do
          SemanticRelease.inc_minor
        end

        desc "Increment patch version (e.g. 1.2.3 => 1.2.4)"
        task :patch do
          SemanticRelease.inc_patch
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
