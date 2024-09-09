//
//  DailyContent.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation

enum MockDailyContentGridItemModel {
    
    static var itemModels: [DailyPreviewModel] {
        [
            DailyPreviewModel(
                id: UUID(),
                thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1083/140/129.jpg?hmac=Dzb3YcrN8FjBEAAF6QRaOZvr96xZ7yKqwHaqw7059B8")!,
                profileImage: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
                title: "Meet our latest rescue, Max! 🐶❤️",
                nickname: "건우"
            ),
            DailyPreviewModel(
                id: UUID(),
                thumbnailURL: URL(string: "https://fastly.picsum.photos/id/717/140/129.jpg?hmac=m1Q5C4dr9QXy6kgYa02L2Ovuu0FNEQcXo-iYqLZ5utM")!,
                profileImage: URL(string: "https://fastly.picsum.photos/id/223/20/20.jpg?hmac=NLTx9PkrP7b2NBeKDewasgY9ZJu4OBS12EUrySkDuvQ")!,
                title: "Meet our latest rescue, Max! 🐶❤️",
                nickname: "욱진"
            ),
            DailyPreviewModel(
                id: UUID(),
                thumbnailURL: URL(string: "https://fastly.picsum.photos/id/882/140/129.jpg?hmac=6p8pHfnBUQt6UrvmQoYc6M3obMrduFHlNvExXHcuNc8")!,
                profileImage: URL(string: "https://fastly.picsum.photos/id/201/20/20.jpg?hmac=Tk6lYaPcPNqIZcKaGZLROf_qzQY4bscdZ8Qyfqx-brM")!,
                title: "Meet our latest rescue, Max! 🐶❤️",
                nickname: "영은"
            ),
            DailyPreviewModel(
                id: UUID(),
                thumbnailURL: URL(string: "https://fastly.picsum.photos/id/975/140/129.jpg?hmac=2BvcVKsviqSPHgkV-Ri_yBNnbnCvmo3fgwy8kKh8oYo")!,
                profileImage: URL(string: "https://fastly.picsum.photos/id/201/20/20.jpg?hmac=Tk6lYaPcPNqIZcKaGZLROf_qzQY4bscdZ8Qyfqx-brM")!,
                title: "Meet our latest rescue, Max! 🐶❤️",
                nickname: "진혁"
            )
        ]
    }
}
