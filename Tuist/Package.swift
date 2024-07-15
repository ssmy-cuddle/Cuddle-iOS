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
            "SwinjectAutoregistration": .framework,
            "TCACoordinators": .framework
        ]
    )
#endif

let package = Package(
    name: "Cuddle",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
        .package(url: "https://github.com/Swinject/Swinject", from: "2.8.0"),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration", from: "2.8.0"),
        .package(url: "https://github.com/johnpatrickmorgan/TCACoordinators", from: "0.10.0")
    ]
)
