//
//  MovieCVCell.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit

class MovieCVCell: UICollectionViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    func configureMovieCell(title: String?, image: String?) {
        
        movieTitleLabel.text = title ?? "Movie"
        let imageURl = URL(string: image ?? "")
        movieImageView.kf.setImage(with: imageURl, placeholder: UIImage.init(named: "MissingPoster"))
        
    }
}
