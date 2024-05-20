//
//  UserModifyViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/17/24.
//

import UIKit

class UserModifyViewController: BaseViewController {

    let userModifyView = UserModifyView()
    
    private let titleLabel = UILabel().then {
        $0.text = "프로필 수정"
        $0.font = UIFont.pretendard(size: 17, weight: .bold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = self.userModifyView
        self.navigationItem.titleView = titleLabel
        userModifyView.doneEditButton.addTarget(self, action: #selector(tappedDoneEditButton), for: .touchUpInside)
    }
    
    
    override func configureStyle() {
        
    }
    
    override func configureDelegate() {
        
    }
    
    override func bind() {
        
    }
    
    @objc func tappedDoneEditButton() {
        let alert = UIAlertController(title: "프로필 수정", message: "변경 사항을 저장하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }


}


