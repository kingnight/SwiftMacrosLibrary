import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct Singleton: MemberMacro {
    public static func expansion<Declaration: DeclGroupSyntax,
                                 Context: MacroExpansionContext>(of node: AttributeSyntax,
                                                                 providingMembersOf declaration: Declaration,
                                                                 in context: Context) throws -> [DeclSyntax] {
        guard [SwiftSyntax.SyntaxKind.classDecl, .structDecl].contains(declaration.kind) else {
            throw MacroDiagnostics.errorMacroUsage(message: "Can only be applied to a struct or class")
        }
        let identifier = (declaration as? StructDeclSyntax)?.name ?? (declaration as? ClassDeclSyntax)?.name ?? ""
        var override = ""
        if let inheritedTypes = (declaration as? ClassDeclSyntax)?.inheritanceClause?.inheritedTypes,
           inheritedTypes.contains(where: { inherited in inherited.type.trimmedDescription == "NSObject" }) {
            override = "override "
        }

        let initializer = try InitializerDeclSyntax("private \(raw: override)init()") {}

        let selfToken: TokenSyntax = "\(raw: identifier.text)()"
        let initShared = FunctionCallExprSyntax(calledExpression: DeclReferenceExprSyntax(baseName: selfToken)) {}
        let sharedInitializer = InitializerClauseSyntax(equal: .equalToken(trailingTrivia: .space),
                                                        value: initShared)

        let staticToken: TokenSyntax = "static"
        let staticModifier = DeclModifierSyntax(name: staticToken)
        var modifiers = DeclModifierListSyntax([staticModifier])

        let isPublicACL = declaration.modifiers.compactMap(\.name.tokenKind.keyword).contains(.public) 
        if isPublicACL {
            let publicToken: TokenSyntax = "public"
            let publicModifier = DeclModifierSyntax(name: publicToken)
            modifiers = modifiers.inserting(publicModifier, at: 0)
        }

        let shared = VariableDeclSyntax(modifiers: modifiers,
                                        .let, name: "shared",
                                        initializer: sharedInitializer)

        return [DeclSyntax(initializer),
                DeclSyntax(shared)]
    }
}

extension TokenKind {
    var keyword: Keyword? {
        switch self {
        case let .keyword(keyword): return keyword
        default: return nil
        }
    }
}

enum MacroDiagnostics {
    struct Message: DiagnosticMessage, Error {
        let message: String
        let diagnosticID: MessageID
        let severity: DiagnosticSeverity
    }

    enum ErrorMacroUsage: Error, CustomStringConvertible {
        case message(String)

        var description: String {
            switch self {
            case .message(let text): return text
            }
        }
    }

    static func diagnostic(node: Syntax,
                           position: AbsolutePosition? = nil,
                           message: Message,
                           highlights: [Syntax]? = nil,
                           notes: [Note] = [],
                           fixIts: [FixIt] = []) -> Diagnostic {
        Diagnostic(node: node, message: message)
    }

    static func errorMacroUsage(message: String) -> ErrorMacroUsage {
        .message(message)
    }
}

extension MacroDiagnostics.Message: FixItMessage {
    var fixItID: MessageID { diagnosticID }
}

