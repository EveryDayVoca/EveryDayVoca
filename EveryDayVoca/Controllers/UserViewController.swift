//
//  UserViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

final class UserViewController: BaseViewController {
    
    let userView = UserView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 정보"
        label.font = UIFont.pretendard(size: 17, weight: .bold)
        label.textColor = UIColor.evText
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.userView
        
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.shadowImage = nil
        
    }
 
    override func configureStyle() {
    }
    
    override func configureDelegate() {
    }
    
    override func bind() {
    }
    
}
