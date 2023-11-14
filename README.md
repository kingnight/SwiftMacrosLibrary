# 

<img src="/Users/kaijin/GitHub/SwiftMacrosLibrary/logo.png" alt="logo" style="zoom: 25%;" />

# About SwiftMacrosLibrary

A handy collection of  Swift Macros to boost your productivity. These macros are collected from examples in [Apple's swift-syntax](https://github.com/apple/swift-syntax), Github,and the Internet.

# Swift Macros

Swift Macros transform your source code when you compile it, letting you avoid writing repetitive code by hand. During compilation, Swift expands any macros in your code before building your code as usual.

## Requirements

* Xcode15.0.1,Swift5.9+

* macOS v10.15+, iOS v13+, tvOS v13+, watchOS v6+, .macCatalyst v13+

# Installation

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `SwiftMacrosLibrary` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/kingnight/SwiftMacrosLibrary.git", from: "0.1.0")
    ]
)
```

Next, add `SwiftMacrosLibrary` to your targets dependencies like so:

```
.target(
    name: "YOUR_TARGET_NAME",
    dependencies: [
        "SwiftMacrosLibrary",
    ]
),
```



# List of All Macros

## ComplexMacros

* @DictionaryStorage
* @Observable
* @MyOptionSet



## Declaration

* \#FuncUnique



## Expression

* \#addBlocker

* \#fontLiteral
* \#stringify
* \#URL
* \#myWarning



##  Extension

* @defaultFatalErrorImplementation
* @equatable



## Member

* @CaseDetection
* @CustomCodable
* @MetaEnum
* @NewType
* @Singleton



## MemberAttribute

* @memberDeprecated
* @wrapStoredProperties



##  Peer

* @AddAsync

* @AddCompletionHandler

* @PeerValueWithSuffixName

  