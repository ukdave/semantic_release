# frozen_string_literal: true

module SemanticRelease
  module Updaters
    class GitTag < BaseUpdater
      def self.update
        tag = "v#{current_version}"
        msg = "Increment version to v#{current_version}"

        `git add #{semver_file} && git commit -m '#{msg}' && git tag #{tag} -a -m '#{Time.now}'`

        branch = `git rev-parse --abbrev-ref HEAD`.chomp
        puts "To push the new tag, use 'git push origin #{branch} --tags'"
        puts "To push build and push the .gem file to rubygems.org use, 'bundle exec rake release'" if gemspec_present?
      end
    end
  end
end
