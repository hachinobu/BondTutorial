//
//  TextInputTableCellVM.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/02.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation
import Bond

class TextInputTableCellVM {
    
    let itemLabelText = Observable<String?>("自由入力")
    let inputText = Observable<String?>("")
    
}