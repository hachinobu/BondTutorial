//
//  TableViewFromObservableArrayMultiCellTableViewController.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/16.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit
import Bond

class TableViewFromObservableArrayMultiCellTableViewController: UITableViewController {

    var tableData = ObservableArray<ObservableArray<(TextInputTableCellVM?, SwitchTableCellVM?)>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTableData()
        bindTableView()
    }
    
    private func generateTableData() {
        let firstSectionData = ObservableArray<(TextInputTableCellVM?, SwitchTableCellVM?)>([(TextInputTableCellVM(), nil), (nil, SwitchTableCellVM()), (nil, SwitchTableCellVM()), (TextInputTableCellVM(), nil)])
        let secondSectionData = ObservableArray<(TextInputTableCellVM?, SwitchTableCellVM?)>([(nil, SwitchTableCellVM()), (TextInputTableCellVM(), nil)])
        tableData = ObservableArray([firstSectionData, secondSectionData])
    }
    
    private func bindTableView() {
        
        tableData.bindTo(tableView) { (indexPath, dataSource, tableView) -> UITableViewCell in
            
            let cellVM = dataSource[indexPath.section][indexPath.row]
            if let textCellVM = cellVM.0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell", forIndexPath: indexPath) as! TextInputTableCell
                textCellVM.itemLabelText.bindTo(cell.itemLabel.bnd_text).disposeIn(cell.bnd_bag)
                textCellVM.inputText.bidirectionalBindTo(cell.itemTextField.bnd_text).disposeIn(cell.bnd_bag)
                return cell
            }
            else if let switchCellVM = cellVM.1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchTableCell
                switchCellVM.itemLabelText.bindTo(cell.itemLabel.bnd_text).disposeIn(cell.bnd_bag)
                switchCellVM.itemSwitchOn.bidirectionalBindTo(cell.itemSwitch.bnd_on).disposeIn(cell.bnd_bag)
                return cell
            }
            return UITableViewCell()
            
        }
        
    }

}
