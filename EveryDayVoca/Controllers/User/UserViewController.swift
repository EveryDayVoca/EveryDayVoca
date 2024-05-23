//
//  UserViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

final class UserViewController: BaseViewController {
    
    // MARK: - property
    private let userView = UserView()
    
    private let coreDataManager = VocaCoreDataManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    // MARK: - life cycles
    override func loadView() {
        view = self.userView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProgressBar()
    }
    
    // MARK: - method
    override func configureStyle() {
        
        let titleLabel = UILabel().then {
            $0.text = "사용자 정보"
            $0.font = UIFont.pretendard(size: 17, weight: .bold)
            $0.textColor = UIColor.evText
            $0.textAlignment = .center
        }
        
        lazy var modifyButton = UIBarButtonItem().then {
            $0.title = "수정"
            $0.style = .plain
            $0.target = self
            $0.action = #selector(tappedModifyButton)
            $0.tintColor = .gray100
        }
        
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = modifyButton
    }
    
    override func bind() {
        let user = userDefaultsManager.fetchUser()
        userView.bind(user: user)
    }
    
    func calculateProgress(level: Int) -> Float {
        let cardDeckData = coreDataManager.cardDeckData
        
        var levels = 0
        
        switch level {
        case 1:
            levels = 288
        case 2:
            levels = 600
        case 3:
            levels = 388
        case 4:
            levels = 315
        default:
            levels = 135
        }
        
        return Float(coreDataManager.calculateMemorizedWordCountByLevel(level: level) / levels)
    }
    
    func setProgressBar() {
        
        // 바 progress
        userView.oneProgressView.progress = self.calculateProgress(level: 1)
        userView.twoProgressView.progress = self.calculateProgress(level: 2)
        userView.threeProgressView.progress = self.calculateProgress(level: 3)
        userView.fourProgressView.progress = self.calculateProgress(level: 4)
        userView.fiveProgressView.progress = self.calculateProgress(level: 5)
        
        // 진도율 text
        userView.oneProgressPercentLabel.text = "\(calculateProgress(level: 1)*100)%"
        userView.twoProgressPercentLabel.text = "\(calculateProgress(level: 2)*100)%"
        userView.threeProgressPercentLabel.text = "\(calculateProgress(level: 3)*100)%"
        userView.fourProgressPercentLabel.text = "\(calculateProgress(level: 4)*100)%"
        userView.fiveProgressPercentLabel.text = "\(calculateProgress(level: 5)*100)%"
    }
    
    @objc func tappedModifyButton() {
        let nextView = UserModifyViewController()
        nextView.completion = { [weak self] in
            guard let self = self else { return }
            
            bind()
        }
        navigationController?.pushViewController(nextView, animated: true)
    }
}
