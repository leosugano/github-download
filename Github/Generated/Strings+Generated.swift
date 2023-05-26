// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Bio: 
  public static let bio = L10n.tr("Localizable", "bio", fallback: "Bio: ")
  /// Blog: 
  public static let blog = L10n.tr("Localizable", "blog", fallback: "Blog: ")
  /// Compania: 
  public static let company = L10n.tr("Localizable", "company", fallback: "Compania: ")
  /// Nome completo: 
  public static let completeName = L10n.tr("Localizable", "completeName", fallback: "Nome completo: ")
  /// Criado: 
  public static let createAt = L10n.tr("Localizable", "createAt", fallback: "Criado: ")
  /// Desc: 
  public static let desc = L10n.tr("Localizable", "desc", fallback: "Desc: ")
  /// Detalhes do Usuário
  public static let detailUser = L10n.tr("Localizable", "detailUser", fallback: "Detalhes do Usuário")
  /// Preencha o campo userName, ele é obrigatório
  public static let errorField = L10n.tr("Localizable", "errorField", fallback: "Preencha o campo userName, ele é obrigatório")
  /// Adicione um UserName
  public static let fillNameFieldError = L10n.tr("Localizable", "fillNameFieldError", fallback: "Adicione um UserName")
  /// Github: 
  public static let github = L10n.tr("Localizable", "github", fallback: "Github: ")
  /// Localizable.strings
  ///   Github
  /// 
  ///   Created by Leonardo Sugano on 23/05/23.
  public static let home = L10n.tr("Localizable", "home", fallback: "Home Usuários")
  /// Licença: 
  public static let lisence = L10n.tr("Localizable", "lisence", fallback: "Licença: ")
  /// Nome: 
  public static let name = L10n.tr("Localizable", "name", fallback: "Nome: ")
  /// Campo obrigatório
  public static let obligatefield = L10n.tr("Localizable", "obligatefield", fallback: "Campo obrigatório")
  /// Campo Obrigatório
  public static let obligateField = L10n.tr("Localizable", "obligateField", fallback: "Campo Obrigatório")
  /// Ok
  public static let ok = L10n.tr("Localizable", "ok", fallback: "Ok")
  /// Ops!
  public static let opsTitle = L10n.tr("Localizable", "opsTitle", fallback: "Ops!")
  /// Repo Nome: 
  public static let repoName = L10n.tr("Localizable", "repoName", fallback: "Repo Nome: ")
  /// Procurar
  public static let search = L10n.tr("Localizable", "search", fallback: "Procurar")
  /// Pesquisa
  public static let serchTitle = L10n.tr("Localizable", "serchTitle", fallback: "Pesquisa")
  /// Tentar novamente
  public static let tryAgainTitle = L10n.tr("Localizable", "tryAgainTitle", fallback: "Tentar novamente")
  /// Erro inesperado
  public static let unexpectError = L10n.tr("Localizable", "unexpectError", fallback: "Erro inesperado")
  /// URL: 
  public static let url = L10n.tr("Localizable", "url", fallback: "URL: ")
  /// User: @
  public static let user = L10n.tr("Localizable", "user", fallback: "User: @")
  /// Username: 
  public static let username = L10n.tr("Localizable", "username", fallback: "Username: ")
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
