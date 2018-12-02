//
//  MessageTemplatesTableViewCell.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class MessageTemplatesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var arrowText: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
