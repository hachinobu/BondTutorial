//
//  BindDisposeViewController.swift
//  BondTutorial
//
//  Created by Nishinobu.Takahiro on 2016/02/01.
//  Copyright © 2016年 hachinobu. All rights reserved.
//

import UIKit
import Bond

class BindDisposeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var upperCaseLabel: UILabel!
    @IBOutlet weak var bindButton: UIButton!
    @IBOutlet weak var disposeButton: UIButton!
    
    let bindDisposeVM = BindDisposeVM()
    var compositeDisposable: CompositeDisposable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI() {
        compositeDisposable = CompositeDisposable()
        let disposable1 = textField.bnd_text.bidirectionalBindTo(bindDisposeVM.text)
        let disposable2 = bindDisposeVM.upperCaseText.bindTo(upperCaseLabel.bnd_text)
        compositeDisposable.addDisposable(disposable1)
        compositeDisposable.addDisposable(disposable2)
    }
    
    @IBAction func bindAction(sender: AnyObject) {
        bindUI()
    }
    
    @IBAction func disposeAction(sender: AnyObject) {
        //dispose()するとisDisposedがtrueになるので今後compositeDisposableにaddDisposableしても追加されない
        compositeDisposable.dispose()
    }

}
