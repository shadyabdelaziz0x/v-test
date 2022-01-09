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
        authorNameLabel.text = movie.author
        setImage(for: movie)
    }
    
    private func setImage(for movie: Movie) {
        var url: URL?
        if movie.imageDownloaded {
            url = URL.fileURLIfExists(fileName: movie.id + AppConstants.shared.IMAGE_EXTENSION)
        } else {
            url = URL(string: movie.downloadUrl)
        }
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let imageRatio: Double = (movie.height ?? 1.0) / (movie.width)
        let transformer = SDImageResizingTransformer(size: CGSize(width: screenWidth , height: screenWidth * CGFloat(imageRatio)), scaleMode: .aspectFit)
        
        movieImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        movieImage.sd_setImage(with: url, placeholderImage: nil, options: .scaleDownLargeImages, context: [SDWebImageContextOption.imageTransformer: transformer], progress: nil) { (image, error, cache, urls) in
            guard let _ = error else {
                return
            }
            self.movieImage.image = R.image.placeholderImage()
        }
    }
    
    func getImage() -> UIImage? {
        return movieImage.image
    }

}
