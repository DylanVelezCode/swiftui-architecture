// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokeServices",
    platforms: [.iOS("15.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PokeServices",
            targets: ["PokeServices"]),
    ],
    dependencies: [
        .package(name: "PokeModels", path: "../PokeModels")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PokeServices",
            dependencies: ["PokeModels"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "PokeServicesTests",
            dependencies: ["PokeServices"],
            resources: []),
    ]
)
