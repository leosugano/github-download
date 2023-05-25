// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Localizable.strings
  ///   Github
  /// 
  ///   Created by Leonardo Sugano on 23/05/23.
  public static let characterTitle = L10n.tr("Localizable", "characterTitle", fallback: "Home Usuarios")
  /// Adicione um Nome
  public static let fillNameFieldError = L10n.tr("Localizable", "fillNameFieldError", fallback: "Adicione um Nome")
  /// Pesquisar
  public static let filterButton = L10n.tr("Localizable", "filterButton", fallback: "Pesquisar")
  /// Pesquisa
  public static let filterTitle = L10n.tr("Localizable", "filterTitle", fallback: "Pesquisa")
  /// Você já está com os últimos dados
  public static let lastDatasMessage = L10n.tr("Localizable", "lastDatasMessage", fallback: "Você já está com os últimos dados")
  /// Sem internet para encontrar o valor colocado nos dados armazenados
  public static let noInternetError = L10n.tr("Localizable", "noInternetError", fallback: "Sem internet para encontrar o valor colocado nos dados armazenados")
  /// Campo Obrigatório
  public static let obligateField = L10n.tr("Localizable", "obligateField", fallback: "Campo Obrigatório")
  /// Ok
  public static let ok = L10n.tr("Localizable", "ok", fallback: "Ok")
  /// Ops!
  public static let opsTitle = L10n.tr("Localizable", "opsTitle", fallback: "Ops!")
  /// Tentar novamente
  public static let tryAgainTitle = L10n.tr("Localizable", "tryAgainTitle", fallback: "Tentar novamente")
  /// Para atualizar com mais dados ligue a sua internet
  public static let turnOnInternet = L10n.tr("Localizable", "turnOnInternet", fallback: "Para atualizar com mais dados ligue a sua internet")
  /// Algo inesperado aconteceu!
  public static let unexpectedError = L10n.tr("Localizable", "unexpectedError", fallback: "Algo inesperado aconteceu!")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
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
