//
//  LocalStorageManager.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import UIKit

class LocalStorageManager: LocalStorageManagerProtocols {
    
    static var shared: LocalStorageManager = LocalStorageManager()
    
    @discardableResult
    func saveImage(imageData: Data, with id: String) -> String? {
        guard let image = UIImage(data: imageData), let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return nil
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        
        do {
            let url = directory.appendingPathComponent("\(id).jpeg")!
            try data.write(to: url)
            return "\(id).jpeg"
        } catch {
            return nil
        }
    }
}
