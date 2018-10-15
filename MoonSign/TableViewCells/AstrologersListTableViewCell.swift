//
//  AstrologersListTableViewCell.swift
//  MoonSign
//
//  Created by Mac on 9/9/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class AstrologersListTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
