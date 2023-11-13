//
//  Plugin.swift
//
//
//  Created by kai jin on 2023/11/13.
//

#if canImport(SwiftCompilerPlugin)
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftMacrosLibraryPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AddAsyncMacro.self,
        AddBlocker.self,
        AddCompletionHandlerMacro.self,
        CaseDetectionMacro.self,
        CodableKey.self,
        CustomCodable.self,
        DefaultFatalErrorImplementationMacro.self,
        DictionaryStorageMacro.self,
        DictionaryStoragePropertyMacro.self,
        EquatableExtensionMacro.self,
        FontLiteralMacro.self,
        FuncUniqueMacro.self,
        MemberDeprecatedMacro.self,
        MetaEnumMacro.self,
        NewTypeMacro.self,
        ObservableMacro.self,
        ObservablePropertyMacro.self,
        OptionSetMacro.self,
        PeerValueWithSuffixNameMacro.self,
        StringifyMacro.self,
        URLMacro.self,
        WarningMacro.self,
        WrapStoredPropertiesMacro.self,
    ]
}

#endif
