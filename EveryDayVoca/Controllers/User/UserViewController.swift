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
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.userView
        
        configureStyle()
        bind()
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
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDefaultsChange(_:)), name: .userDefaultsDidChange, object: nil)
    }
    
    func calculateProgress(level: Int) -> Float {
        if UserDefaults.standard.integer(forKey: "1total") != 0 {
            return Float(VocaCoreDataManager.shared.calculateMemorizedWordCountByLevel(level: level) / UserDefaults.standard.integer(forKey: "1total"))
        }
        else {
            return 0
        }
    }
    
    func setProgressBar() {
        userView.oneProgressView.progress = self.calculateProgress(level: 1)
        userView.twoProgressView.progress = self.calculateProgress(level: 2)
        userView.threeProgressView.progress = self.calculateProgress(level: 3)
        userView.fourProgressView.progress = self.calculateProgress(level: 4)
        userView.fiveProgressView.progress = self.calculateProgress(level: 5)
        
        userView.oneProgressPercentLabel.text = "\(calculateProgress(level: 1)*100)%"
        userView.twoProgressPercentLabel.text = "\(calculateProgress(level: 2)*100)%"
        userView.threeProgressPercentLabel.text = "\(calculateProgress(level: 3)*100)%"
        userView.fourProgressPercentLabel.text = "\(calculateProgress(level: 4)*100)%"
        userView.fiveProgressPercentLabel.text = "\(calculateProgress(level: 5)*100)%"
    }
    
    @objc func tappedModifyButton() {
        let nextView = UserModifyViewController()
        navigationController?.pushViewController(nextView, animated: true)
    }

    @objc func handleUserDefaultsChange(_ notification: Notification) {
        if let value = UserDefaults.standard.string(forKey: "userName") {
            self.userView.userNameLabel.text = value
        }
        if let value = UserDefaults.standard.string(forKey: "userNickName") {
            self.userView.userNickNameLabel.text = value
        }
        if let value = UserDefaults.standard.string(forKey: "studyLevel") {
            self.userView.studyLevelLabel.text = value
        }
        if let value = UserDefaults.standard.string(forKey: "studyAmount") {
            self.userView.studyAmountLabel.text = value
        }
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            self.userView.profileImage.image = image
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .userDefaultsDidChange, object: nil)
    }

}
