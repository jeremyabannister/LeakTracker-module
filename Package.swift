// swift-tools-version: 5.8

///
import PackageDescription

///
let package = Package(
    name: "LeakTracker-module",
    products: [
        .library(
            name: "LeakTracker-module",
            targets: ["LeakTracker-module"]
        ),
    ],
    dependencies: [],
    targets: [
        
        ///
        .target(
            name: "LeakTracker-module",
            dependencies: []
        ),
        
        ///
        .testTarget(
            name: "LeakTracker-tests",
            dependencies: ["LeakTracker-module"]
        ),
    ]
)
