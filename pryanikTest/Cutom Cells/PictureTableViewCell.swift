//
//  PictureTableViewCell.swift
//  pryanikTest
//
//  Created by Олег Бабыр on 06.06.2021.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    @IBOutlet var pryanikPictureTextLabel: UILabel!
    @IBOutlet var pryanikPictureImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
