//
//  BindDisposeVM.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/01.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation
import Bond

class BindDisposeVM {
    
    let text = Observable<String?>("")
    
    var upperCaseText: EventProducer<String?> {
        return text.map { $0?.uppercaseString }
    }
    
}