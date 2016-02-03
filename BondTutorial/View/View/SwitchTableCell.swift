//
//  SwitchTableCell.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/02.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit
import Bond

class SwitchTableCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bnd_bag.dispose()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
