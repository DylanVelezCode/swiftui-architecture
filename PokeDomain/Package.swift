// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokeDomain",
    platforms: [.iOS("14.1")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PokeDomain",
            targets: ["PokeDomain"]),
    ],
    dependencies: [
        .package(name: "PokeArch", path: "../PokeArch"),
        .package(name: "PokeServices", path: "../PokeServices"),
        .package(name: "PokeModels", path: "../PokeModels")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PokeDomain",
            dependencies: ["PokeArch", "PokeServices", "PokeModels"])
    ]
)
