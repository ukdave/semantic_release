# frozen_string_literal: true

module SemanticRelease
  module Updaters
    class GitTag < BaseUpdater
      # rubocop:disable Style/GuardClause
      def self.update
        tag = current_version_tag
        msg = "Increment version to #{tag}"

        `git add #{semver_file} && git commit -m '#{msg}' && git tag #{tag} -a -m '#{Time.now}'`

        branch = `git rev-parse --abbrev-ref HEAD`.chomp
        puts "To push the new tag, use 'git push origin #{branch} --tags'"

        if gemspec_present? && !SemanticRelease.configuration.disable_rubygems_message
          puts "To build and push the .gem file to rubygems.org use, 'bundle exec rake release'"
        end
      end
      # rubocop:enable Style/GuardClause
    end
  end
end
