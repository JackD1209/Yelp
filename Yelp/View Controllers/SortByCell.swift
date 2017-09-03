//
//  SortByCell.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 9/2/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SortByCellDelegate {
    func sortByCell(dropCell: SortByCell, didClick imageClicked: UIImage)
}

class SortByCell: UITableViewCell {

    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var sortByImage: UIImageView!
    
    var delegate: SortByCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Delegate to check whenever the arrow is clicked to expand the hidden options
        if delegate != nil {
            delegate.sortByCell(dropCell: self, didClick: sortByImage.image!)
        }
        // Configure the view for the selected state
    }
    
}
