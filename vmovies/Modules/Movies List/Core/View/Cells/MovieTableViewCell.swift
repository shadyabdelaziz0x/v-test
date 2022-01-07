//
//  MovieTableViewCell.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
