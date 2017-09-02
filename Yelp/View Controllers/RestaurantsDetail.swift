//
//  RestaurantsDetail.swift
//  RestaurantsFinder
//
//  Created by Đoàn Minh Hoàng on 7/16/17.
//  Copyright © 2017 Đoàn Minh Hoàng. All rights reserved.
//

import UIKit

class RestaurantsDetail: UITableViewCell {

    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var rateImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var cateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
