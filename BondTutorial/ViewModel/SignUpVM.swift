//
//  SignUpVM.swift
//  BondTutorial
//
//  Created by Takahiro Nishinobu on 2016/01/31.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import Foundation
import Bond

class SignUpVM {
    
    enum RequestState {
        case None
        case Requesting
        case Finish
    }
    
    let requestState = Observable<RequestState>(.None)
    let loginID = Observable<String?>("")
    let password = Observable<String?>("")
    let passwordConfirmation = Observable<String?>("")
    let isAgreement = Observable<Bool>(false)
    
    var isLoadingViewAnimate: EventProducer<Bool> {
        return requestState.map { $0 == .Requesting }
    }
    
    var isLoadingViewHidden: EventProducer<Bool> {
        return requestState.map { $0 != .Requesting }
    }
    
    var finishSignUp: EventProducer<(email: String, password: String)?> {
        
        return requestState.map { [weak self] reqState in
            
            guard let email = self?.loginID.value, password = self?.password.value where reqState == .Finish else {
                return nil
            }
            
            return (email, password)
        
        }
        
    }
    
    var signUpViewStateInfo: EventProducer<(buttonEnabled: Bool, buttonAlpha: CGFloat, warningMessage: String)> {
        
        return combineLatest(requestState, loginID, password, passwordConfirmation, isAgreement).map { (reqState, loginID, password, passwordConfirmation, isAgreement) in
            
            guard let loginID = loginID, password = password, passwordConfirmation = passwordConfirmation where reqState != .Requesting else {
                return (false, 0.5, "")
            }
            
            if loginID.isEmpty || password.isEmpty || passwordConfirmation.isEmpty {
                return (false, 0.5, "")
            }
            
            guard password == passwordConfirmation else {
                return (false, 0.5, "パスワードと確認パスワードが一致していません")
            }
            
            guard isAgreement else {
                return (false, 0.5, "規約に同意してください")
            }
            
            return (true, 1.0, "")
            
        }
        
    }
    
    func signUp() {
        
        requestState.next(.Requesting)
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue()) { [unowned self] in
            self.requestState.next(.Finish)
        }
        
    }
    
}