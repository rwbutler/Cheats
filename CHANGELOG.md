# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2019-07-25
### Changed
- Updated to Swift 5.0.

## [1.2.2] - 2019-02-04
### Changed
- Improvements to example app UI.

## [1.2.1] - 2019-01-24
### Changed
- Updated the `tap(_)` action to `tap(times:)`.

## [1.2.0] - 2019-01-20
### Added
- Added support for taps as part of a cheat's action sequence.

## [1.1.1] - 2019-01-18
### Changed
- Fixed an issue with shake actions not being counted towards the cheat sequence correctly.

## [1.1.0] - 2019-01-17
### Added
- Added a new state `reset` for the case whereby the cheat code sequence has not yet begun or has been reset.
### Changed
- Removed unneeded to call `reset()` from `ViewController` as the gesture recognizer will reset for us.

## [1.0.0] - 2019-01-16
### Added
- Added significant project documentation.
- Added support for screen shake actions.
### Changed
- Resolved warnings raised by SwiftLint.

## [0.0.2] - 2019-01-16
### Changed
- Made `Cheats` scheme shared for Carthage compatibility.

## [0.0.1] - 2019-01-16
### Added
- Initial release.