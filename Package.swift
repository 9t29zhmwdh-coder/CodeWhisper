// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CodeWhisper",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(
            name: "CodeWhisper",
            path: "Sources/CodeWhisper",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .testTarget(
            name: "CodeWhisperTests",
            dependencies: ["CodeWhisper"],
            path: "Tests/CodeWhisperTests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
    ]
)
