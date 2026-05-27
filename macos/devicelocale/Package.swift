// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "devicelocale",
    platforms: [
        .macOS("10.14")
    ],
    products: [
        .library(name: "devicelocale", targets: ["devicelocale"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "devicelocale",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            cSettings: [
                .headerSearchPath("include/devicelocale")
            ]
        )
    ]
)
