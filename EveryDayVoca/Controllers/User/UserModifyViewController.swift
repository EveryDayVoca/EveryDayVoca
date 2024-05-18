//
//  UserModifyViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/17/24.
//

import UIKit

class UserModifyViewController: UIViewController {

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
    }
    


}


