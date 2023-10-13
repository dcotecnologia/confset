# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2023-10-13

### Changed

#### Breaking Changes

- `config` no longer loads `deep_merge`'s monkey patch for `Hash#deep_merge` and Hash#deep_merge!`([#342](https://github.com/rubyconfig/config/pull/342)). If you rely on those methods and are not using Rails / Active Support, you can load the monkey patch via`require 'deep_merge/deep_merge_hash'` by @jonathanhefner

### Fixed

- Address edge case with table config param (#339) by @krasnoukhov

## [1.0.3] - 2023-02-17

### Changed

- Update project dependencies by @danilogco
- Add `ruby v3.2.x` to the test matrix by @danilogco

### Fixed

- Fix indentation warning (rubyconfig#322) by @lygaret
- Fix typo Padrino (rubyconfig#325) by @ytkg
- Fix CI setting for Ruby 3.0 (rubyconfig#326) by @ytkg
- Remove `Gemfile.lock` from the package by @danilogco

## [1.0.2] - 2022-06-06

### Changed

- Only load Railtie integration if Rails::Railtie is defined
  [rubyconfig#31](https://github.com/rubyconfig/config/pull/319) - Thanks to Ufuk
  Kayserilioglu <ufuk.kayserilioglu@shopify.com>
- CHANGELOG.md pattern changed to the [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2022-05-30

### Fixed

- Avoid to crash the Rails application when there is an error
  parsing a variable <https://github.com/dcotecnologia/confset/pull/5>

## [1.0.0] - 2022-05-27

### Added

- Initial release
- Refac the project focusing on the newer versions of the
  Ruby language and Ruby on Rails.

---

You can find the full changelog of the original "config" gem at the link
<https://github.com/rubyconfig/config/blob/master/CHANGELOG.md>.
