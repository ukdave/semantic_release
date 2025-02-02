# SemanticRelease

This gem helps you to manage the version number of your application or library.

Use the provided Rake tasks to:

- bump the major, minor, or patch number of your version
- automatically update our verison file (e.g. `lib/version.rb`)
- automatically update your changelog (`CHANGELOG.md` or `history.rdoc`)
- automatically create a git commit and tag for the release

This gem was inspired by:

- SemVer2 (https://github.com/haf/semver)
- Rake-n-Bake (https://github.com/RichardVickerstaff/rake-n-bake)
- Version Manager (https://github.com/tpbowden/version_manager)

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add semantic_release
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install semantic_release
```

## Usage

Add the Rake task by adding the following lines to a Rake configuration file (e.g. `Rakefile` or `lib/tasks/default.rake`):

```ruby
require "semantic_release/rake_task"
SemanticRelease::RakeTask.new
```

The following tasks are available:

```
rake semantic_release:init
rake semantic_release:current
rake semantic_release:major
rake semantic_release:minor
rake semantic_release:patch
```

To get the current version inside your application:

```ruby
SemanticRelease.current_version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ukdave/semantic_release.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
