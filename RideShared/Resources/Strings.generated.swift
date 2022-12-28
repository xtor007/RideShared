// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum Button {
    /// Close
    internal static let close = Strings.tr("Localizable", "button.close", fallback: "Close")
    /// Finish
    internal static let finish = Strings.tr("Localizable", "button.finish", fallback: "Finish")
  }
  internal enum CarColor {
    /// Black
    internal static let black = Strings.tr("Localizable", "carColor.black", fallback: "Black")
    /// Light
    internal static let light = Strings.tr("Localizable", "carColor.light", fallback: "Light")
    /// White
    internal static let white = Strings.tr("Localizable", "carColor.white", fallback: "White")
  }
  internal enum DriverInfo {
    /// Do you want to become a driver?
    internal static let question = Strings.tr("Localizable", "driverInfo.question", fallback: "Do you want to become a driver?")
  }
  internal enum Error {
    internal enum Error {
      /// Error
      internal static let title = Strings.tr("Localizable", "error.error.title", fallback: "Error")
    }
    internal enum Questionnaire {
      /// You must set value for music preferences
      internal static let musicField = Strings.tr("Localizable", "error.questionnaire.musicField", fallback: "You must set value for music preferences")
      /// Error in filling
      internal static let title = Strings.tr("Localizable", "error.questionnaire.title", fallback: "Error in filling")
    }
    internal enum SingIn {
      /// Sign in error
      internal static let title = Strings.tr("Localizable", "error.singIn.title", fallback: "Sign in error")
    }
  }
  internal enum GenderBlock {
    /// Female
    internal static let female = Strings.tr("Localizable", "genderBlock.female", fallback: "Female")
    /// Male
    internal static let male = Strings.tr("Localizable", "genderBlock.male", fallback: "Male")
  }
  internal enum General {
    /// RideShared
    internal static let title = Strings.tr("Localizable", "general.title", fallback: "RideShared")
    /// Yes
    internal static let yes = Strings.tr("Localizable", "general.yes", fallback: "Yes")
  }
  internal enum Google {
    /// Sign in with Google
    internal static let singIn = Strings.tr("Localizable", "google.singIn", fallback: "Sign in with Google")
  }
  internal enum Importance {
    /// Hight
    internal static let hight = Strings.tr("Localizable", "importance.hight", fallback: "Hight")
    /// Low
    internal static let low = Strings.tr("Localizable", "importance.low", fallback: "Low")
    /// Medium
    internal static let medium = Strings.tr("Localizable", "importance.medium", fallback: "Medium")
    /// Not Matter
    internal static let notMatter = Strings.tr("Localizable", "importance.notMatter", fallback: "Not Matter")
  }
  internal enum MusicBlock {
    /// Write your music wishes
    internal static let placeholder = Strings.tr("Localizable", "musicBlock.placeholder", fallback: "Write your music wishes")
  }
  internal enum ProfileList {
    /// My Adresses
    internal static let adresses = Strings.tr("Localizable", "profileList.adresses", fallback: "My Adresses")
    /// Driver Settings
    internal static let driverSettings = Strings.tr("Localizable", "profileList.driverSettings", fallback: "Driver Settings")
    /// Prioritets
    internal static let priotitets = Strings.tr("Localizable", "profileList.priotitets", fallback: "Prioritets")
  }
  internal enum Questionnaire {
    /// Driver age
    internal static let age = Strings.tr("Localizable", "questionnaire.age", fallback: "Driver age")
    /// Car color
    internal static let color = Strings.tr("Localizable", "questionnaire.color", fallback: "Car color")
    /// Driver gender
    internal static let gender = Strings.tr("Localizable", "questionnaire.gender", fallback: "Driver gender")
    /// Music
    internal static let music = Strings.tr("Localizable", "questionnaire.music", fallback: "Music")
    /// Speed
    internal static let speed = Strings.tr("Localizable", "questionnaire.speed", fallback: "Speed")
    /// Fill out the questionnaire for a better driver selection
    internal static let title = Strings.tr("Localizable", "questionnaire.title", fallback: "Fill out the questionnaire for a better driver selection")
  }
  internal enum SpeedBlock {
    /// Fast
    internal static let fast = Strings.tr("Localizable", "speedBlock.fast", fallback: "Fast")
    /// Medium
    internal static let medium = Strings.tr("Localizable", "speedBlock.medium", fallback: "Medium")
    /// Slow
    internal static let slow = Strings.tr("Localizable", "speedBlock.slow", fallback: "Slow")
  }
  internal enum TabBar {
    /// Profile
    internal static let profile = Strings.tr("Localizable", "tabBar.profile", fallback: "Profile")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
