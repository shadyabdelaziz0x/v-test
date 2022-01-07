//
//  MovieTableViewCell.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    func bind(movie: Movie) {
        let url: URL? = URL(string: movie.downloadUrl)
        let width: CGFloat = (0.9 * UIScreen.main.bounds.width) - 20
        SDImageCache.shared.config.maxMemoryCost = UInt(width) * 180 * 4 * 20 // 20 images (1024 * 1024 pixels)
        let transformer = SDImageResizingTransformer(size: CGSize(width: width , height: 180), scaleMode: .aspectFit)
        movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        movieImage.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed, context: [SDWebImageContextOption.imageTransformer: transformer])
    }

}
