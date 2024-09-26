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
            "Lottie": .framework,
            "NavigationTransitions": .framework,
            "KakaoSDK": .framework,
            "PopupView": .framework
        ]
    )
#endif

let package = Package(
    name: "Cuddle",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.0"),
        .package(url: "https://github.com/davdroman/swiftui-navigation-transitions", from: "0.13.4"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", branch: "master"),
        .package(url: "https://github.com/exyte/PopupView.git", from: "3.1.0")
    ]
)
