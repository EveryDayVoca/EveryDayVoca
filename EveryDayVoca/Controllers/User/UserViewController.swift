//
//  UserViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

final class UserViewController: BaseViewController {
    
    let userView = UserView()
    private let titleLabel = UILabel().then {
        $0.text = "사용자 정보"
        $0.font = UIFont.pretendard(size: 17, weight: .bold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .center
    }
    
    lazy var modifyButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(tappedModifyButton))
    
//    let modifyButton = UIBarButtonItem().then {
//        $0.title = "수정"
//        $0.style = .plain
//        $0.target = self
//        $0.action = #selector(tappedModifyButton)
//        $0.tintColor = .gray50
//    }
    

    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.userView
    
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.shadowImage = nil
        navigationItem.rightBarButtonItem = modifyButton
    }
    
    @objc func tappedModifyButton() {
        let nextView = UserModifyViewController()
        navigationController?.pushViewController(nextView, animated: true)
    }
    
    
    override func configureStyle() {
       
    }
    
    override func configureDelegate() {
    }
    
    override func bind() {
    }
    
    
}
