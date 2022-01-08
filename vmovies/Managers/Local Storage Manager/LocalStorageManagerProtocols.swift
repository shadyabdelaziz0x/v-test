//
//  LocalStorageManagerProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import UIKit

protocol LocalStorageManagerProtocols {
    func saveImage(imageData: Data, with id: String) -> String?
}
