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
        
//        tableData.performBatchUpdates { (p) -> Void in
//            p[0].performBatchUpdates { (data) -> Void in
////                data.removeAtIndex(2)
//                data.removeAtIndex(0)
////                data.append(BasicTableCellVM(labelText: "Add Row2"))
//                data.insert(BasicTableCellVM(labelText: "Add Row3"), atIndex: 1)
////                data.append(BasicTableCellVM(labelText: "Add Row2"))
////                data.append(BasicTableCellVM(labelText: "Add Row3"))
//            }
//        }
        
//        //このやり方だと即時更新され3回reloadが走る
//        tableData[0].append(BasicTableCellVM(labelText: "Add Row"))
//        tableData[0].append(BasicTableCellVM(labelText: "Add Row1"))
//        tableData[0].append(BasicTableCellVM(labelText: "Add Row2"))
        
        tableData[0].performBatchUpdates { (tableData) -> Void in
            tableData.append(BasicTableCellVM(labelText: "Add Row"))
            tableData.removeAtIndex(1)
            tableData.append(BasicTableCellVM(labelText: "Add Row2"))
            tableData.removeAtIndex(0)
            tableData.append(BasicTableCellVM(labelText: "Add Row3"))
        }
        
        
        //performBatchUpdatesを使用するとデータが全て更新されてからreloadが1度走る
//        tableData.performBatchUpdates { (tableData) -> Void in
//            tableData[0].performBatchUpdates { (data) -> Void in
//                data.append(BasicTableCellVM(labelText: "Add Row"))
//                data.append(BasicTableCellVM(labelText: "Add Row2"))
//                data.append(BasicTableCellVM(labelText: "Add Row3"))
//            }
//        }
        
//        tableData.performBatchUpdates { (tableData) -> Void in
//            tableData.insert(ObservableArray([BasicTableCellVM(labelText: "Add Section")]), atIndex: 0)
//            tableData.insert(ObservableArray([BasicTableCellVM(labelText: "Add Section")]), atIndex: 0)
//            tableData.insert(ObservableArray([BasicTableCellVM(labelText: "Add Section")]), atIndex: 0)
//        }
        
        
    }
    
    private func generateTableData() {
        for _ in 0..<5 {
            let cellVMList = ObservableArray<BasicTableCellVM>()
            for i in 0..<6 {
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
        
        //どのやり方しても何回か移動させているとクラッシュする
        //ObservableArrayに変更が加わると差分のBatchが生成され、それにそってdeleteRowsAtIndexPathsなどが発火されるがユーザーが動かしているから既にそのIndexPathは存在しない
        let data = tableData[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
        tableData[destinationIndexPath.section].insert(data, atIndex: destinationIndexPath.row)
        
//        tableData.performBatchUpdates { (datas) -> Void in
//            let data = datas[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
//            datas[destinationIndexPath.section].insert(data, atIndex: destinationIndexPath.row)
//        }
        
        
//        tableData[0].performBatchUpdates { (tableData) -> Void in
//            tableData.append(BasicTableCellVM(labelText: "Add Row"))
//            tableData.removeAtIndex(1)
//            tableData.append(BasicTableCellVM(labelText: "Add Row2"))
//            tableData.removeAtIndex(0)
//            tableData.append(BasicTableCellVM(labelText: "Add Row3"))
//        }
//        tableView.reloadData()
        
//        tableData.performBatchUpdates { sections -> Void in
//            
//            let targetData = sections[sourceIndexPath.section][sourceIndexPath.row]
//            
//            sections[sourceIndexPath.section].performBatchUpdates { (rows) -> Void in
//                rows.removeAtIndex(sourceIndexPath.row)
//            }
//            
//            sections[destinationIndexPath.section].performBatchUpdates { (rows) -> Void in
//                rows.insert(targetData, atIndex: destinationIndexPath.row)
//            }
//            
//        }
        
//        let targetDatas = tableData.array[sourceIndexPath.section].array.removeAtIndex(sourceIndexPath.row)
//        tableData.array[destinationIndexPath.section].array.insert(targetDatas, atIndex: destinationIndexPath.row)
        
        
//        var allSection = tableData.array
//        var removeSection = tableData[sourceIndexPath.section].array
//        let target = removeSection.removeAtIndex(sourceIndexPath.row)
//        var insertSection = tableData[destinationIndexPath.section].array
//        insertSection.insert(target, atIndex: destinationIndexPath.row)
////        tableData[sourceIndexPath.section].array = removeSection
////        tableData[destinationIndexPath.section].array = insertSection
//        allSection[sourceIndexPath.section].array = removeSection
//        allSection[destinationIndexPath.section].array = insertSection
//        tableData.array = allSection
        
//        let target = tableData[sourceIndexPath.section].array.removeAtIndex(sourceIndexPath.row)
//        tableData[destinationIndexPath.section].array.insert(target, atIndex: destinationIndexPath.row)
        
//        tableView.beginUpdates()
//        var sections = tableData.array
//        let targetData = sections[sourceIndexPath.section].array.removeAtIndex(sourceIndexPath.row)
//        sections[destinationIndexPath.section].array.insert(targetData, atIndex: destinationIndexPath.row)
//        tableData.array = sections
//        tableView.endUpdates()
        
//        if sourceIndexPath.section == destinationIndexPath.section {
//            
//            var rows = tableData[sourceIndexPath.section].array
//            let target = rows.removeAtIndex(sourceIndexPath.row)
//            rows.insert(target, atIndex: destinationIndexPath.row)
//            tableData[sourceIndexPath.section].array = rows
//            
//        }
        
//        let datas = tableData
//        
//        datas.performBatchUpdates { (sections) -> Void in
//            let data = sections[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
//            sections[destinationIndexPath.section].insert(data, atIndex: destinationIndexPath.row)
//        }
        
//        tableView.beginUpdates()
//        let data = tableData[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
//        tableData[destinationIndexPath.section].insert(data, atIndex: destinationIndexPath.row)
//        tableView.reloadData()
//        tableView.endUpdates()
        
//        tableView.reloadData()
        
//        tableData[sourceIndexPath.section].performBatchUpdates { rowDatas -> Void in
//            let data = rowDatas.removeAtIndex(sourceIndexPath.row)
//            rowDatas.insert(data, atIndex: destinationIndexPath.row)
//        }
        
//        let data = tableData[sourceIndexPath.section].removeAtIndex(sourceIndexPath.row)
//        tableData[destinationIndexPath.section].insert(data, atIndex: destinationIndexPath.row)
        
        
//        tableData[sourceIndexPath.section].performBatchUpdates { rowDatas -> Void in
//            
//            rowDatas.removeAtIndex(sourceIndexPath.row)
//            rowDatas.insert(data, atIndex: destinationIndexPath.row)
//            
//        }
        
//        tableView.reloadData()
        
        
        
//        guard sourceIndexPath.section == destinationIndexPath.section else {
//            let data = tableData[sourceIndexPath.section][sourceIndexPath.row]
//            tableData[destinationIndexPath.section].insert(data, atIndex: sourceIndexPath.row)
//            return
//        }
//        
//        print("sourceIndexPath: \(sourceIndexPath.row)")
//        print("destinationIndexPath: \(destinationIndexPath.row)")
//        let section = sourceIndexPath.section
//        tableData[section].performBatchUpdates { rowData -> Void in
//            let data = rowData[sourceIndexPath.row]
//            rowData.removeAtIndex(sourceIndexPath.row)
//            rowData.insert(data, atIndex: destinationIndexPath.row)
//        }
        
//        tableData.performBatchUpdates { (tableData) -> Void in
//            
//            tableData[section].performBatchUpdates { (data) -> Void in
//                
//                let addData = data[sourceIndexPath.row]
//                data.removeAtIndex(sourceIndexPath.row)
//                data.insert(addData, atIndex: destinationIndexPath.row)
//                
//            }
//            
//        }
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
        return .Bottom
    }
    
}
