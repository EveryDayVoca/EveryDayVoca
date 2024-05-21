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
        setNavigationController()
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
    
    func setNavigationController() {
        let navigationBarTitleLabel = UILabel().then {
            $0.text = "나의 단어 사전"
            $0.font = UIFont.pretendard(size: 17, weight: .semibold)
            $0.textAlignment = .center
        }
        
        let navigationBarPlusButton = UIBarButtonItem().then {
            $0.image = UIImage(named: "plus")
            $0.target = self
            $0.action = #selector(tappedNavigationBarPlusButton)
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.evText
        self.navigationItem.titleView = navigationBarTitleLabel
        self.navigationItem.rightBarButtonItem = navigationBarPlusButton
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @objc func tappedNavigationBarPlusButton() {
        let addVocaVC = VocaBookAddVocaViewController()
        present(addVocaVC, animated: true)
    }
    
}
