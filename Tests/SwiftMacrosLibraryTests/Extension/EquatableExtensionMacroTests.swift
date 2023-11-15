//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import MacrosImplementation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class EquatableExtensionMacroTests: XCTestCase {
  private let macros = ["equatable": EquatableExtensionMacro.self]

  func testExpansionAddsExtensionWithEquatableConformance() {
    assertMacroExpansion(
      """
      @equatable
      final public class Message {
        let text: String
        let sender: String
      }
      """,
      expandedSource: """
        final public class Message {
          let text: String
          let sender: String
        }

        extension Message: Equatable {
        }
        """,
      macros: macros,
      indentationWidth: .spaces(2)
    )
  }
}
