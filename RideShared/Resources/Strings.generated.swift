// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum General {
    /// RideShared
    internal static let title = Strings.tr("Localizable", "general.title", fallback: "RideShared")
  }
  internal enum Google {
    /// Sing in with Google
    internal static let singIn = Strings.tr("Localizable", "google.singIn", fallback: "Sing in with Google")
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
