# frozen_string_literal: true

require_relative "lib/semantic_release/version"

Gem::Specification.new do |spec|
  spec.name = "semantic_release"
  spec.version = SemanticRelease::VERSION
  spec.authors = ["David Bull"]
  spec.email = ["david@uk-dave.com"]

  spec.summary = "Rake tasks to help you to manage your version number and releases"
  spec.description = <<~DESCRIPTION
    This gem helps you to manage the version number of your application or library. It provides Rake tasks to
    automatically update your version file, changelog file, and create a git tag.
  DESCRIPTION
  spec.homepage = "https://github.com/ukdave/semantic_release"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ukdave/semantic_release"
  spec.metadata["changelog_uri"] = "https://github.com/ukdave/semantic_release/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).select do |f|
      f.start_with?(*%w[CHANGELOG.md LICENSE.txt README.md lib])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
