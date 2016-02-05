//
//  TextInputTableCell.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/02.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit
import Bond

class TextInputTableCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        print("cell.itemTextField.bnd_text.value: \(itemTextField.bnd_text.value)")
//        print("cell.itemTextField.bnd_text.deinitDisposable.disposables.count: \(itemTextField.bnd_text.deinitDisposable.enableDisposableCount())")
//        print("cell: \(itemTextField.bnd_text.observers)")
//        itemTextField.bnd_text.deinitDisposable.dispose()
//        bnd_bag.dispose()
        
//        itemTextField.bnd_text.deinitDisposable.dispose()
        print("------ beforeDispose---------")
        print(itemTextField.bnd_text.deinitDisposable.enableDisposableCount())
        print(itemTextField.bnd_text.observers)
        print("itemTextField: \(itemTextField.bnd_text.value)")
//        bnd_bag.dispose()
        print("--------- prepareForReuse -------------")
        print(itemTextField.bnd_text.deinitDisposable.enableDisposableCount())
        print(itemTextField.bnd_text.observers)
        print("itemTextField: \(itemTextField.bnd_text.value)")
//        bnd_bag.dispose()
//        itemTextField.bnd_text.deinitDisposable.disposables
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
