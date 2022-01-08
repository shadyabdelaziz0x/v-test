//
//  AppConstants.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation

struct AppConstants {
    private init() { }
    static let shared: AppConstants = AppConstants()
    //constants
    let MOVIES_BATCH_SIZE: Int = 20
    let IMAGE_EXTENSION: String = ".jpeg"
    let maxImageCacheSize = 1024 * 1024 * 4 * 20 // 20 images (1024 * 1024 pixels)
}
