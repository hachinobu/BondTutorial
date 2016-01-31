//
//  MessageSendViewController.swift
//  BondTutorial
//
//  Created by Takahiro Nishinobu on 2016/01/31.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit

class MessageSendViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageCountLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    var messageSendVM = MessageSendVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        setupBind()
    }
    
    private func setupBind() {
        messageSendVM.message.bidirectionalBindTo(messageTextView.bnd_text)
        messageSendVM.messageTextColor.bindTo(messageTextView.bnd_textColor)
        messageSendVM.messageCount.map { String($0) }.bindTo(messageCountLabel.bnd_text)
        messageSendVM.messageCountColor.bindTo(messageCountLabel.bnd_textColor)
        messageSendVM.buttonStateInfo.observe { [unowned self] (enabled, alpha) in
            self.sendButton.enabled = enabled
            self.sendButton.alpha = alpha
        }
        
        sendButton.bnd_tap.observe { [unowned self] _ in
            self.messageSendVM.sendMessage { (message) -> Void in
                let alertController = UIAlertController(title: "メッセージ", message: message, preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(action)
                self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MessageSendViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        messageSendVM.textViewTapAction()
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        messageSendVM.textViewEndAction()
    }
    
}
