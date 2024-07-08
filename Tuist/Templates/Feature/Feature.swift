import ProjectDescription

let featureName = Template.Attribute.required("name")

let featureTemplate = Template(
    description: "A Feature Template",
    attributes: [featureName],
    items: [
        .file(
            path: "Projects/Feature/\(featureName)Feature/Project.swift",
            templatePath: "Feature.stencil"
        ),
        .string(
            path: "Projects/Feature/\(featureName)Feature/Sources/Source.swift",
            contents: "// for test"
        ),
        .string(
            path: "Projects/Feature/\(featureName)Feature/Interface/Sources/Source.swift",
            contents: "// for test"
        ),
        .string(
            path: "Projects/Feature/\(featureName)Feature/Testing/Sources/Source.swift",
            contents: "// for test"
        ),
        .string(
            path: "Projects/Feature/\(featureName)Feature/Testing/Resources/dummy.txt",
            contents: "// autogenerated by tuist."
        ),
        .file(
            path: "Projects/Feature/\(featureName)Feature/Example/Sources/ExampleApp.swift",
            templatePath: "FeatureExample.stencil"
        ),
        .string(
            path: "Projects/Feature/\(featureName)Feature/Tests/Sources/Source.swift",
            contents: "// for test"
        )
    ]
)
