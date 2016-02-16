//
//  SwitchTableCellVM.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/02.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation
import Bond

class SwitchTableCellVM {
    
    let itemLabelText = Observable<String?>("SwiftBond好きですか？")
    let itemSwitchOn = Observable<Bool>(false)
    
}
