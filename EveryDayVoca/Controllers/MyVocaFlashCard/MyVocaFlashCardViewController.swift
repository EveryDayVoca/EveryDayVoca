//
//  MyVocaFlashCardViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class MyVocaFlashCardViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let myVocaFlashCardView = MyVocaFlashCardView()
    
    var index: Int = 0
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = myVocaFlashCardView
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Methods
    
    override func configureStyle() { 
        super.configureStyle()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
    }
    
    override func bind() {
        super.bind()
        myVocaFlashCardView.bind(index: index)
    }
    
    func changeIndex(index: Int) {
        self.index = index
    }

}
