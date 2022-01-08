//
//  LocalStorageManagerProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import UIKit
import SwiftyUserDefaults

protocol LocalStorageManagerProtocols {
    @discardableResult
    func saveImage(imageData: Data, with id: String) -> String?
}
