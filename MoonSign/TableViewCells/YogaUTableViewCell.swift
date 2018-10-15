//
//  YogaUTableViewCell.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class YogaUTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var titleText: UILabel!
    
    
    @IBOutlet weak var detailText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
