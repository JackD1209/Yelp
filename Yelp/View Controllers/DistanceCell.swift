//
//  DistanceCell.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 9/2/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol DistanceCellDelegate {
    func distanceCell(dropCell: DistanceCell, didClick imageClicked: UIImage)
}

class DistanceCell: UITableViewCell {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceImage: UIImageView!
    
    var delegate: DistanceCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Delegate to check whenever the arrow is clicked to expand the hidden options
        if delegate != nil {
            delegate.distanceCell(dropCell: self, didClick: distanceImage.image!)
        }
        // Configure the view for the selected state
    }
    
}
