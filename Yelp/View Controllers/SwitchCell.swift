//
//  SwitchCell.swift
//  Yelp
//
//  Created by Đoàn Minh Hoàng on 9/2/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didSwitch value: Bool)
}


class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchToggle: UISwitch!
    
    var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Delegate to send bool value whenever the swith is togged
    @IBAction func isSwitched(_ sender: UISwitch) {
        delegate?.switchCell(switchCell: self, didSwitch: sender.isOn)
    }
}
