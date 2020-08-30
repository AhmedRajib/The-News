//
//  customTableViewCell.swift
//  The News
//
//  Created by MacBook Pro on 27/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lvl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        img.layer.cornerRadius = 20
//        img.clipsToBounds = true
        
        img.backgroundColor = UIColor.white
        img.layer.cornerRadius = 8.0
        img.clipsToBounds = true
        
        lvl.backgroundColor = UIColor.lightGray
        lvl.layer.cornerRadius = 8.0
        lvl.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


