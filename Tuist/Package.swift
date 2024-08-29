// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
            "ComposableArchitecture": .framework,
            "Swinject": .framework,
            "Lottie": .framework
        ]
    )
#endif

let package = Package(
    name: "Cuddle",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.0")
    ]
)
