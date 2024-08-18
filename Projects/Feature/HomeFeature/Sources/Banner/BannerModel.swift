//
//  BannerModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import AppResource

public struct BannerModel {
    public let imageURL: URL
    
    public init(imageURL: URL) {
        self.imageURL = imageURL
    }
}

extension BannerModel: Equatable {}

enum MockBanner {
    static let banners: [BannerModel] = [
        BannerModel(imageURL: URL(string: "https://fastly.picsum.photos/id/505/580/142.jpg?hmac=XW4bB6PspAljl6PMt2s-cKkhvb2JYZuYeWRyLlCTCcM")!),
        BannerModel(imageURL: URL(string: "https://fastly.picsum.photos/id/1082/580/142.jpg?hmac=gr7wjj_f_647exC_N3RID3ngq8o-hSpDGqlaKQS1hJs")!),
        BannerModel(imageURL: URL(string: "https://fastly.picsum.photos/id/212/580/142.jpg?hmac=q_MLzFYHoXpkvLFIYpjz-whxn4wroPR0RcVBB81Rvew")!),
        BannerModel(imageURL: URL(string: "https://fastly.picsum.photos/id/264/580/142.jpg?hmac=zvNEqQKsUsoVLNdMwOOn__Lbivo80QeSv9VhMNGiEWg")!),
    ]
}
