//
//  URLExtension.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation

extension URL {
    static func fileURL(fileName: String) throws -> URL {
        let baseUrl = try FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask,
            appropriateFor: nil, create: false)
        return baseUrl.appendingPathComponent(fileName)
    }

    static func fileURLIfExists(fileName: String) -> URL? {
        do {
            let url = try fileURL(fileName: fileName)
            return FileManager.default.fileExists(atPath: url.path) ? url : nil
        } catch {
            return nil
        }
    }
}
