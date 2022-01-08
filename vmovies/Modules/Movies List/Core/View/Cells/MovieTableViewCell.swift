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
    @IBOutlet private weak var movieImage: UIImageView!
    
    func bind(movie: Movie) {
        let url: URL? = URL(string: movie.downloadUrl)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let imageRatio: Double = movie.height / movie.width
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 4 * 20 // 20 images (1024 * 1024 pixels)
        let transformer = SDImageResizingTransformer(size: CGSize(width: screenWidth , height: screenWidth * CGFloat(imageRatio)), scaleMode: .aspectFit)
        movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        movieImage.sd_setImage(with: url, placeholderImage: nil, options: .scaleDownLargeImages, context: [SDWebImageContextOption.imageTransformer: transformer])
        
        movieImage.sd_setImage(with: url, placeholderImage: nil, options: .scaleDownLargeImages, context: [SDWebImageContextOption.imageTransformer: transformer], progress: nil) { (image, error, cache, urls) in
            guard let _ = error, let localImageUrl = URL.fileURLIfExists(fileName: movie.id + ".jpeg") else { return }
            self.movieImage.sd_setImage(with: localImageUrl)
        }
    }
    
    func getImage() -> UIImage? {
        return movieImage.image
    }

}
