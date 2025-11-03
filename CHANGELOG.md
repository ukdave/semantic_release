- ci: Bump actions/checkout from 4 to 5
- chore: Update development dependencies
- feat: Drop support for Ruby 3.1 which has reached End of Life

## v1.3.0 (10 February 2025)

- feat: Add config option to hide message about building and pushing the .gem file to rubygems.org
- fix: Prefix version number in changelog files with 'v'
- ci: Add rake_announcer gem

## v1.2.1 (06 February 2025)

- docs: Fix release instructions to clarify that you need to push the tag _and_ run `rake release`

## v1.2.0 (06 February 2025)

- feat: Mention 'rake release' in git tag updater output if a gemspec file is present
- feat: Stage Gemfile.lock after bumping version.rb if a gemspec file is present

## v1.1.0 (03 February 2025)

- Add check to prevent re-initialising if semver file already exists
- Add configuration options for semver file
- Change rake task namespace from `semantic_release` to `release` and make configurable

## v1.0.1 (02 February 2025)

- Add blank line after version number in changelog
- Remove unnecessary files from gem

## v1.0.0 (02 February 2025)

- Initial release
