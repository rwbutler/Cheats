![Cheats](https://raw.githubusercontent.com/rwbutler/Cheats/master/docs/images/cheats-banner.png)

[![CI Status](https://img.shields.io/travis/rwbutler/Cheats.svg?style=flat)](https://travis-ci.org/rwbutler/Cheats)
[![Version](https://img.shields.io/cocoapods/v/Cheats.svg?style=flat)](https://cocoapods.org/pods/Cheats)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Maintainability](https://api.codeclimate.com/v1/badges/db29ef6403045460c11b/maintainability)](https://codeclimate.com/github/rwbutler/Cheats/maintainability)
[![License](https://img.shields.io/cocoapods/l/FeatureFlags.svg?style=flat)](http://cocoapods.org/pods/Cheats)
[![Platform](https://img.shields.io/cocoapods/p/FeatureFlags.svg?style=flat)](http://cocoapods.org/pods/Cheats)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org/)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

Cheats is an implementation of console-style [cheat codes](https://en.wikipedia.org/wiki/Cheating_in_video_games#Cheat_codes) (such as [the Konami code](https://en.wikipedia.org/wiki/Konami_Code)) for iOS apps. It includes a `UIGestureRecognizer` for recognizing cheat codes. Combine a sequence of actions consisting of swipes, shake gestures, taps and key presses to create a cheat code for unlocking features or [Easter eggs](https://en.wikipedia.org/wiki/Easter_egg_(media)) in your app.

## Features

- [x] Combine a sequence of actions to make a [cheat code](https://en.wikipedia.org/wiki/Cheating_in_video_games#Cheat_codes) for unlocking a feature or Easter egg in an iOS app.
- [x] Provides a `UIGestureRecognizer` for ease of integration with `UIViewController`.
- [x] Available for integration through Cocoapods, Carthage or Swift Package Manager.

![Cheats](https://raw.githubusercontent.com/rwbutler/Cheats/master/docs/images/example.gif)

To learn more about how to use Cheats, take a look at the [blog post](https://medium.com/@rwbutler/retro-video-game-cheat-codes-for-ios-apps-82a6e46ea386) or make use of the table of contents below:

- [Features](#features)
- [Installation](#installation)
	- [Cocoapods](#cocoapods)
	- [Carthage](#carthage)
	- [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
	- [Making a Cheat Code](#making-a-cheat-code)
		- [Reset](#reset)
		- [Actions](#actions)
	- [Gesture Recognizers](#gesture-recognizers)
- [Example](#example)
- [Author](#author)
- [License](#license)
- [Additional Software](#additional-software)
	- [Frameworks](#frameworks)
	- [Tools](#tools)

## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager which integrates dependencies into your Xcode workspace. To install it using [RubyGems](https://rubygems.org/) run:

```bash
gem install cocoapods
```

To install FeatureFlags using Cocoapods, simply add the following line to your Podfile:

```ruby
pod "Cheats"
```

Then run the command:

```bash
pod install
```

For more information [see here](https://cocoapods.org/#getstarted).

### Carthage

Carthage is a dependency manager which produces a binary for manual integration into your project. It can be installed via [Homebrew](https://brew.sh/) using the commands:

```bash
brew update
brew install carthage
```

In order to integrate Cheats into your project via Carthage, add the following line to your project's Cartfile:

```ogdl
github "rwbutler/Cheats"
```

From the macOS Terminal run `carthage update --platform iOS` to build the framework then drag `Cheats.framework` into your Xcode project.

For more information [see here](https://github.com/Carthage/Carthage#quick-start).

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a dependency manager for Swift modules and is included as part of the build system as of Swift 3.0. It is used to automate the download, compilation and linking of dependencies.

To include Cheats as a dependency within a Swift package, add the package to the `dependencies` entry in your `Package.swift` file as follows:

```swift
dependencies: [
    .package(url: "https://github.com/rwbutler/Cheats.git", from: "2.0.0")
]
```

## Usage

Cheats consists of a core and UI component - only the core component is available through Swift Package Manager due to the dependency of the UI component on UIKit.

### Making a Cheat Code

Creating a cheat code involves creating a sequence of actions that the user must perform correctly in order to unlock the cheat. Action may consist of swipes or key presses:

```swift
let actionSequence: [CheatCode.Action] = [.swipe(.up), .swipe(.down), .swipe(.left), .swipe(.right), .keyPress("a"), .keyPress("b")]
```

Once the sequence of actions has been defined, instantiate a `Cheat` and optionally provide a callback which will be invoked to feedback the user's progress as they complete the sequence of actions required to unlock the cheat:


```swift
let cheat = CheatCode(actions: actionSequence) { [weak self] cheatCode in
    switch cheatCode.state() {
        case .matched: // correct
            print("Cheat unlocked!")
        case .matching: // correct *so far*
            print("Further actions required to unlock cheat.")
        case .notMatched: // incorrect
            print("Cheat incorrect.") 
        case .reset: // initial state / sequence reset
            print("Cheat code sequence reset")      
}
```

As shown in the above code snippet, it is possible to query the  state of the `CheatCode` at any time via the `state()` function on the `CheatCode` instance. The `CheatCode.State` enum is able to take on three states:

- `matched` - indicates that the user has successfully completed the cheat code.
- `matching` - indicates that the user has partially completed the cheat code with further actions required in order to successfully unlock the cheat.
- `notMatched` - indicates that the user got one of the actions wrong whilst attempting the cheat code action sequence.
- `reset` - indicates that the user has not yet begun to input the cheat code sequence or the sequence has been reset to its initial state.

#### Reset

Should the `CheatCode` enter the `.notMatched` state then the user cannot retry the cheat until `reset()` has been invoked to reset the user's sequence of actions. If using the `CheatCodeGestureRecognizer` (see below), this is performed automatically by the gesture recognizer.

#### Actions

Actions are the building blocks of cheat code sequences. Available actions are:

- `keyPress` - For whenever a key on the keyboard is pressed.
- `shake` - When the user shakes the device.
- `swipe` - In the directions `up`, `down`, `left` and `right`.
- `tap` - Specified with the number of taps required.

If at any time, the next action required to complete the cheat code sequence is needed, this can be retrieve using `nextAction()` which optionally returns a `CheatCode.Action` if any further actions are required in order to complete the sequence.

Likewise `previousAction()` will return the last action successfully completed by the user as part of the cheat code sequence.

### Gesture Recognizers

Cheats provides the `CheatCodeGestureRecognizer`, a subclass of [`UIGestureRecognizer`](https://developer.apple.com/documentation/uikit/uigesturerecognizer), to make integration with UIViewController / UIView straightforward. 

To make use of the gesture recognizer, instantiate it with a `CheatCode` instance as described above along with the target and action selector (as you would with any other `UIGestureRecognizer`). Then simply add the gesture recognizer to the desired view:

```swift 
let gestureRecognizer = CheatCodeGestureRecognizer(cheatCode: cheatCode, target: self, action: #selector(actionPerformed(_:)))
view.addGestureRecognizer(gestureRecognizer)
```

## Example

An example app can be found in the [Example](./Example/) directory as an illustration of how to use the framework. To run, clone the repo and then open `Cheats.xcworkspace` in Xcode.

## Author

[Ross Butler](https://github.com/rwbutler)

## License

Cheats is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.

## Additional Software

### Controls

* [AnimatedGradientView](https://github.com/rwbutler/AnimatedGradientView) - Powerful gradient animations made simple for iOS.

|[AnimatedGradientView](https://github.com/rwbutler/AnimatedGradientView) |
|:-------------------------:|
|[![AnimatedGradientView](https://raw.githubusercontent.com/rwbutler/AnimatedGradientView/master/docs/images/animated-gradient-view-logo.png)](https://github.com/rwbutler/AnimatedGradientView) 

### Frameworks

* [Cheats](https://github.com/rwbutler/Cheats) - Retro cheat codes for modern iOS apps.
* [Connectivity](https://github.com/rwbutler/Connectivity) - Improves on Reachability for determining Internet connectivity in your iOS application.
* [FeatureFlags](https://github.com/rwbutler/FeatureFlags) - Allows developers to configure feature flags, run multiple A/B or MVT tests using a bundled / remotely-hosted JSON configuration file.
* [FlexibleRowHeightGridLayout](https://github.com/rwbutler/FlexibleRowHeightGridLayout) - A UICollectionView grid layout designed to support Dynamic Type by allowing the height of each row to size to fit content.
* [Hash](https://github.com/rwbutler/Hash) - Lightweight means of generating message digests and HMACs using popular hash functions including MD5, SHA-1, SHA-256.
* [Skylark](https://github.com/rwbutler/Skylark) - Fully Swift BDD testing framework for writing Cucumber scenarios using Gherkin syntax.
* [TailorSwift](https://github.com/rwbutler/TailorSwift) - A collection of useful Swift Core Library / Foundation framework extensions.
* [TypographyKit](https://github.com/rwbutler/TypographyKit) - Consistent & accessible visual styling on iOS with Dynamic Type support.
* [Updates](https://github.com/rwbutler/Updates) - Automatically detects app updates and gently prompts users to update.

|[Cheats](https://github.com/rwbutler/Cheats) |[Connectivity](https://github.com/rwbutler/Connectivity) | [FeatureFlags](https://github.com/rwbutler/FeatureFlags) | [Skylark](https://github.com/rwbutler/Skylark) | [TypographyKit](https://github.com/rwbutler/TypographyKit) | [Updates](https://github.com/rwbutler/Updates) |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
|[![Cheats](https://raw.githubusercontent.com/rwbutler/Cheats/master/docs/images/cheats-logo.png)](https://github.com/rwbutler/Cheats) |[![Connectivity](https://github.com/rwbutler/Connectivity/raw/master/ConnectivityLogo.png)](https://github.com/rwbutler/Connectivity) | [![FeatureFlags](https://raw.githubusercontent.com/rwbutler/FeatureFlags/master/docs/images/feature-flags-logo.png)](https://github.com/rwbutler/FeatureFlags) | [![Skylark](https://github.com/rwbutler/Skylark/raw/master/SkylarkLogo.png)](https://github.com/rwbutler/Skylark) | [![TypographyKit](https://raw.githubusercontent.com/rwbutler/TypographyKit/master/docs/images/typography-kit-logo.png)](https://github.com/rwbutler/TypographyKit) | [![Updates](https://raw.githubusercontent.com/rwbutler/Updates/master/docs/images/updates-logo.png)](https://github.com/rwbutler/Updates)

### Tools

* [Clear DerivedData](https://github.com/rwbutler/ClearDerivedData) - Utility to quickly clear your DerivedData directory simply by typing `cdd` from the Terminal.
* [Config Validator](https://github.com/rwbutler/ConfigValidator) - Config Validator validates & uploads your configuration files and cache clears your CDN as part of your CI process.
* [IPA Uploader](https://github.com/rwbutler/IPAUploader) - Uploads your apps to TestFlight & App Store.
* [Palette](https://github.com/rwbutler/TypographyKitPalette) - Makes your [TypographyKit](https://github.com/rwbutler/TypographyKit) color palette available in Xcode Interface Builder.

|[Config Validator](https://github.com/rwbutler/ConfigValidator) | [IPA Uploader](https://github.com/rwbutler/IPAUploader) | [Palette](https://github.com/rwbutler/TypographyKitPalette)|
|:-------------------------:|:-------------------------:|:-------------------------:|
|[![Config Validator](https://raw.githubusercontent.com/rwbutler/ConfigValidator/master/docs/images/config-validator-logo.png)](https://github.com/rwbutler/ConfigValidator) | [![IPA Uploader](https://raw.githubusercontent.com/rwbutler/IPAUploader/master/docs/images/ipa-uploader-logo.png)](https://github.com/rwbutler/IPAUploader) | [![Palette](https://raw.githubusercontent.com/rwbutler/TypographyKitPalette/master/docs/images/typography-kit-palette-logo.png)](https://github.com/rwbutler/TypographyKitPalette)