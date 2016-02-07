//
//  TableViewDataDetailViewcontroller.swift
//  BondTutorial
//
//  Created by Takahiro Nishinobu on 2016/02/07.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit
import Bond

class TableViewDataDetailViewcontroller: UIViewController {

    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var tableData: ObservableArray<ObservableArray<BasicTableCellVM>>!
    var selectIndexPath: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func bindUI() {
        tableData[selectIndexPath.section][selectIndexPath.row].labelText.bidirectionalBindTo(editTextField.bnd_text)
        deleteButton.bnd_tap.throttle(NSTimeInterval(0.1), queue: Queue.Main).observe { [unowned self] _ in
            
            self.tableData.performBatchUpdates { tableData in
                tableData[self.selectIndexPath.section].removeAtIndex(self.selectIndexPath.row)
            }
            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }

}
