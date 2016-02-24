//
//  SignUpViewController.swift
//  BondTutorial
//
//  Created by Takahiro Nishinobu on 2016/01/31.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var loginIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var agreementSwitch: UISwitch!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var signUpVM = SignUpVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBind()
    }

    private func setupBind() {
        
        signUpVM.loginID.bidirectionalBindTo(loginIDTextField.bnd_text)
        signUpVM.password.bidirectionalBindTo(passwordTextField.bnd_text)
        signUpVM.passwordConfirmation.bidirectionalBindTo(passwordConfirmationTextField.bnd_text)
        signUpVM.isAgreement.bidirectionalBindTo(agreementSwitch.bnd_on)
        
        signUpVM.signUpViewStateInfo.observe { [weak self] (buttonEnabled, buttonAlpha, warningMessage) -> Void in
            self?.warningLabel.text = warningMessage
            self?.signUpButton.enabled = buttonEnabled
            self?.signUpButton.alpha = buttonAlpha
        }
        
        signUpVM.isLoadingViewHidden.bindTo(loadingIndicator.bnd_hidden)
        signUpVM.isLoadingViewAnimate.bindTo(loadingIndicator.bnd_animating)
        
        signUpButton.bnd_controlEvent.filter { $0 == .TouchUpInside }.observe { [weak self] _ -> Void in
            self?.signUpVM.signUp()
        }
        
        signUpVM.finishSignUp.ignoreNil().observe { [weak self] (email, password) -> Void in
            let alertController = UIAlertController(title: "メッセージ", message: "loginID:\(email)\npassword:\(password)", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(action)
            self?.navigationController?.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
}
