//
//  Movie.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation

class Movie: Codable {
    let id                         : String
    let author                     : String
    let width                      : Double
    let height                     : Double?
    let url                        : String
    let downloadUrl                : String
    let imageDownloaded            : Bool
    
    init(id: String, author: String, width: Double, height: Double, url: String, downloadUrl: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.downloadUrl = downloadUrl
        imageDownloaded = false
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case download_url
        case image_downloaded
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.author, forKey: .author)
        try container.encode(self.width, forKey: .width)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.downloadUrl, forKey: .download_url)
        try container.encode(self.imageDownloaded, forKey: .image_downloaded)
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id =  try values.decode(String.self, forKey: .id)
        self.author = try values.decode(String.self, forKey: .author)
        self.width = try values.decode(Double.self, forKey: .width)
        self.height = try values.decode(Double?.self, forKey: .height)
        self.url = try values.decode(String.self, forKey: .url)
        self.downloadUrl = try values.decode(String.self, forKey: .download_url)
        self.imageDownloaded = try values.decodeIfPresent(Bool.self, forKey: .image_downloaded) ?? false
    }
}

extension Movie {
    var debugDescription: String {
        return """
            id: \(id),
            author: \(author),
            width: \(width),
            height: \(height ?? 0.0),
            url: \(url),
            downloadUrl: \(downloadUrl),
            imageDownloaded: \(imageDownloaded)
        """
    }
}
