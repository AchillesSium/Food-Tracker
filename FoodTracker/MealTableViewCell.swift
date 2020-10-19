//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Mobioapp on 5/18/17.
//  Copyright © 2017 Mobioapp. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    @IBOutlet weak var ratingControl: ratingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
