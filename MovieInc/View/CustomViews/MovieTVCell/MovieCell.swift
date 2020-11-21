//
//  MovieCell.swift
//  MovieInc
//
//  Created by Bahi El Feky on 11/20/20.
//  Copyright © 2020 Bahi El Feky. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var voteLbl: UILabel!
    @IBOutlet weak var posterImageV: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
