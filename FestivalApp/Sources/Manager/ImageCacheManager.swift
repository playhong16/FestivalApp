//
//  ImageCacheManager.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/10.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
