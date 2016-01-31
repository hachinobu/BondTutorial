//
//  MessageSendVM.swift
//  BondTutorial
//
//  Created by Takahiro Nishinobu on 2016/01/31.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation
import Bond

class MessageSendVM {
    
    static let PlaceholderMessage = "タップしてメッセージを入力してください"
    static let MaxMessageCount = 10
    
    let message = Observable<String?>(PlaceholderMessage)
    var messageTextColor: EventProducer<UIColor> {
        return message.map { message in
            if message == MessageSendVM.PlaceholderMessage {
                return UIColor.lightGrayColor()
            }
            return UIColor.blackColor()
        }
    }
    
    var messageCount: EventProducer<Int> {
        
        return message.map { message in
            
            if message == MessageSendVM.PlaceholderMessage {
                return MessageSendVM.MaxMessageCount
            }
            
            guard let count = message?.characters.count where count > 0 else {
                return MessageSendVM.MaxMessageCount
            }
            
            return MessageSendVM.MaxMessageCount - count
        }
        
    }
    
    var messageCountColor: EventProducer<UIColor> {
        
        return message.map { message in
            return message?.characters.count
        }.map{ count in
            if count > MessageSendVM.MaxMessageCount {
                return UIColor.redColor()
            }
            return UIColor.blackColor()
        }
        
    }
    
    var buttonStateInfo: EventProducer<(enabled: Bool, alpha: CGFloat)> {
        
        return message.map { message in
            
            if message == MessageSendVM.PlaceholderMessage || message?.characters.count == 0 || message?.characters.count > MessageSendVM.MaxMessageCount {
                return (false, 0.5)
            }
            return (true, 1.0)
            
        }
        
    }
    
    func textViewTapAction() {
        
        guard message.value == MessageSendVM.PlaceholderMessage else {
            return
        }
        message.next("")
        
    }
    
    func textViewEndAction() {
        
        if message.value?.characters.count > 0 {
            return
        }
        message.next(MessageSendVM.PlaceholderMessage)
        
    }
    
    func sendMessage(result: (String -> Void)) {
        result(message.value!)
    }
    
}