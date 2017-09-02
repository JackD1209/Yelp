//
//  DropListCell.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 9/2/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class DropListCell: UITableViewCell {

    @IBOutlet weak var dropListLabel: UILabel!
    @IBOutlet weak var dropListImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
