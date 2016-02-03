//
//  TableViewCellBindViewController.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/02.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit

class TableViewCellBindViewController: UITableViewController {

    var tableData = [[TextInputTableCellVM]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func generateTableData() {
        
        var cellVMList = [TextInputTableCellVM]()
        for _ in 0..<5 {
            
            for _ in 0..<5 {
                cellVMList.append(TextInputTableCellVM())
            }
            
            tableData.append(cellVMList)
            cellVMList.removeAll()
            
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let vm = tableData[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell", forIndexPath: indexPath) as! TextInputTableCell
//        vm.itemLabelText.bindTo(cell.itemLabel.bnd_text).disposeIn(cell.bnd_bag)
//        vm.inputText.bidirectionalBindTo(cell.itemTextField.bnd_text).disposeIn(cell.bnd_bag)
        let dispose = vm.itemLabelText.bindTo(cell.itemLabel.bnd_text)
        let dispose2 = vm.inputText.bidirectionalBindTo(cell.itemTextField.bnd_text)
        print(dispose)
        print(dispose2)
        
        
//        cell.itemLabel.bnd_text.bidirectionalBindTo(vm.itemLabelText)
//        cell.itemTextField.bnd_text.bidirectionalBindTo(vm.inputText)
        return cell
        
    }

}
