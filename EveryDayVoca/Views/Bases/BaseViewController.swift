//
//  BaseViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    func configureStyle()
    func configureDelegate()
    func bind()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        configureDelegate()
        bind()
    }
    
    func configureStyle() { }
    
    func configureDelegate() { }
    
    func bind() { }
}
