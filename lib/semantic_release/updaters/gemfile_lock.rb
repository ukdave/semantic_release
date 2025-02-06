# frozen_string_literal: true

module SemanticRelease
  module Updaters
    class GemfileLock < BaseUpdater
      def self.update
        return unless gemspec_present?
        return if system("git check-ignore -q Gemfile.lock")

        `bundle check && git add Gemfile.lock`
      end
    end
  end
end
