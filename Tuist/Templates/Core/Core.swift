import ProjectDescription

private let pathAttribute = Template.Attribute.required("targetPath")

private let template = Template(
    description: "A template for a new dynamic framework",
    attributes: [
        pathAttribute
    ],
    items: [
        .string(
            path: "\(pathAttribute)/Sources/Source.swift",
            contents: "// Autogenerated by Tuist"
        ),
        .string(
            path: "\(pathAttribute)/Resources/dummy.txt",
            contents: "dummy file"
        )
    ]
)