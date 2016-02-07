//
//  TableViewFromObservableArrayTableViewController.swift
//  BondTutorial
//
//  Created by Takahiro Nishinobu on 2016/02/06.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit
import Bond

class TableViewFromObservableArrayTableViewController: UITableViewController {

    var tableData = ObservableArray<ObservableArray<BasicTableCellVM>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addData"))
        self.navigationItem.rightBarButtonItems = [item, self.editButtonItem()]
        generateTableData()
        bindTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func addData() {
        //このやり方だと即時更新され3回reloadが走る
//        tableData[0].append(BasicTableCellVM(labelText: "Add Row"))
//        tableData[0].append(BasicTableCellVM(labelText: "Add Row1"))
//        tableData[0].append(BasicTableCellVM(labelText: "Add Row2"))
        
        //performBatchUpdatesを使用するとデータが全て更新されてからreloadが1度走る
//        tableData.performBatchUpdates { (tableData) -> Void in
//            tableData[0].performBatchUpdates { (data) -> Void in
//                data.append(BasicTableCellVM(labelText: "Add Row"))
//                data.append(BasicTableCellVM(labelText: "Add Row2"))
//                data.append(BasicTableCellVM(labelText: "Add Row3"))
//            }
//        }
        
        tableData.performBatchUpdates { (tableData) -> Void in
            tableData.insert(ObservableArray([BasicTableCellVM(labelText: "Add Section")]), atIndex: 0)
            tableData.insert(ObservableArray([BasicTableCellVM(labelText: "Add Section")]), atIndex: 0)
            tableData.insert(ObservableArray([BasicTableCellVM(labelText: "Add Section")]), atIndex: 0)
        }
        
        
    }
    
    private func generateTableData() {
        for _ in 0..<5 {
            let cellVMList = ObservableArray<BasicTableCellVM>()
            for i in 0..<5 {
                cellVMList.append(BasicTableCellVM(labelText: "\(i)"))
            }
            tableData.append(cellVMList)
        }
    }
    
    private func bindTableView() {
        
        tableData.bindTo(tableView, proxyDataSource: self) { [unowned self] (indexPath, dataSource, tableView) -> UITableViewCell in
            
            let vm = self.tableData[indexPath.section][indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("ObservableArrayCell", forIndexPath: indexPath)
            cell.bnd_bag.dispose()
            vm.labelText.bidirectionalBindTo(cell.textLabel!.bnd_text).disposeIn(cell.bnd_bag)
            return cell
            
        }
        
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! TableViewDataDetailViewcontroller
        vc.tableData = tableData
        vc.selectIndexPath = tableView.indexPathForSelectedRow!
    }
    
}

extension TableViewFromObservableArrayTableViewController: BNDTableViewProxyDataSource {
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header In Section"
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer In Section"
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tableData.performBatchUpdates { tableData in
                tableData[indexPath.section].removeAtIndex(indexPath.row)
            }
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        guard sourceIndexPath.section == destinationIndexPath.section else {
            tableData[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
            tableData[destinationIndexPath.section].removeAtIndex(destinationIndexPath.row)
            return
        }
        
        let section = sourceIndexPath.section
        tableData.performBatchUpdates { (tableData) -> Void in
            
            tableData[section].performBatchUpdates { (data) -> Void in
                
                
                
            }
            
        }
    }
    
    //アニメーションせず一括でreloadDataにするか
    func shouldReloadInsteadOfUpdateTableView(tableView: UITableView) -> Bool {
        return false
    }
    
    //Rowが更新された時のアニメーション
    func tableView(tableView: UITableView, animationForRowAtIndexPaths indexPaths: [NSIndexPath]) -> UITableViewRowAnimation {
        return .Fade
    }
    
    //Sectionが更新された時のアニメーション
    func tableView(tableView: UITableView, animationForRowInSections sections: Set<Int>) -> UITableViewRowAnimation {
        return .Left
    }
    
}
