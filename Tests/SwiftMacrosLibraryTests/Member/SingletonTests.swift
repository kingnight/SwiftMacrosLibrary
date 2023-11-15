import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(MacrosImplementation)
import MacrosImplementation

let testMacros: [String: Macro.Type] = [
    "Singleton": Singleton.self,
]
#endif

final class SingletonTests: XCTestCase {
    func testMacro() throws {
        #if canImport(SingletonMacros)
        assertMacroExpansion(
            """
            #stringify(a + b)
            """,
            expandedSource: """
            (a + b, "a + b")
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testMacroWithStringLiteral() throws {
        #if canImport(SingletonMacros)
        assertMacroExpansion(
            #"""
            #stringify("Hello, \(name)")
            """#,
            expandedSource: #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testSingletonMacro() {
        assertMacroExpansion(
            """
            @Singleton
            struct A {
            }
            """,
            expandedSource: """
            struct A {
            
                private init() {
                }
            
                static let shared = A()
            }
            """,
            macros: testMacros
        )
    }

    func testPublicSingletonMacro() {
        assertMacroExpansion(
            """
            @Singleton
            public struct A {
            }
            """,
            expandedSource: """

            public struct A {
            
                private init() {
                }
            
                public static let shared = A()
            }
            """,
            macros: testMacros
        )
    }
    
}
