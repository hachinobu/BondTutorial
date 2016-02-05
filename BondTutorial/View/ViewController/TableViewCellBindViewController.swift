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
        print("---------------- generateVM ----------------")
        print("vmValue: \(vm.inputText.value!)")
        print("vm.inputText.deinitDisposable.disposables.count: \(vm.inputText.deinitDisposable.enableDisposableCount())")
        print("vm: \(vm.inputText.observers)")
        
        vm.inputText.deinitDisposable.dispose()
        
        print("-------- ViewController -------------")
        print("section:\(indexPath.section)  row:\(indexPath.row)")
        print("vmValue: \(vm.inputText.value!)")
        print("vm.inputText.deinitDisposable.disposables.count: \(vm.inputText.deinitDisposable.enableDisposableCount())")
        print("vm: \(vm.inputText.observers)")
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell", forIndexPath: indexPath) as! TextInputTableCell
        print("-------------- beforeBind -------------")
        print("vm.inputText.deinitDisposable.disposables.count: \(vm.inputText.deinitDisposable.enableDisposableCount())")
        print("vm: \(vm.inputText.observers)")
        
//        vm.itemLabelText.bindTo(cell.itemLabel.bnd_text).disposeIn(cell.bnd_bag)
//        vm.inputText.bidirectionalBindTo(cell.itemTextField.bnd_text).disposeIn(cell.bnd_bag)
//        vm.itemLabelText.bindTo(cell.itemLabel.bnd_text)
        vm.inputText.bidirectionalBindTo(cell.itemTextField.bnd_text)
        
//        print("------------ cellforrow -----------")
//        print("section:\(indexPath.section)  row:\(indexPath.row)")
//        print("cell.itemTextField.bnd_text.value: \(cell.itemTextField.bnd_text.value)")
//        print("cell.itemTextField.bnd_text.deinitDisposable.disposables.count: \(cell.itemTextField.bnd_text.deinitDisposable.enableDisposableCount())")
//        print("cell: \(cell.itemTextField.bnd_text.observers)")
//        print("vm.inputText.value: \(vm.inputText.value)")
        
         print("-------- bind --------")
        print("------ afterReuse VireController --------")
        print("vm.inputText.deinitDisposable.disposables.count: \(vm.inputText.deinitDisposable.enableDisposableCount())")
        print("vm: \(vm.inputText.observers)")
        print("")
        print("cell.itemTextField.bnd_text.deinitDisposable.enableDisposableCount(): \(cell.itemTextField.bnd_text.deinitDisposable.enableDisposableCount())")
        print("cell.itemTextField.bnd_text.observers: \(cell.itemTextField.bnd_text.observers)")
        
//        vm.inputText.deinitDisposable.dispose()
//        cell.itemTextField.bnd_text.deinitDisposable.dispose()
        
//        print("------------- dispose --------------")
//        print("section:\(indexPath.section)  row:\(indexPath.row)")
//        print("cell.itemTextField.bnd_text.value: \(cell.itemTextField.bnd_text.value)")
//        print("cell.itemTextField.bnd_text.deinitDisposable.disposables.count: \(cell.itemTextField.bnd_text.deinitDisposable.enableDisposableCount())")
//        print("cell: \(cell.itemTextField.bnd_text.observers)")
//        print("vm.inputText.value: \(vm.inputText.value)")
//        print("vm.inputText.deinitDisposable.disposables.count: \(vm.inputText.deinitDisposable.enableDisposableCount())")
//        print("vm: \(vm.inputText.observers)")
        
        
//        cell.itemLabel.bnd_text.bidirectionalBindTo(vm.itemLabelText)
//        cell.itemTextField.bnd_text.bidirectionalBindTo(vm.inputText)
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableData[indexPath.section][indexPath.row].outPutValue()
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TextInputTableCell
        print("cell:\(cell.itemTextField.bnd_text.value)")
        
    }

}
