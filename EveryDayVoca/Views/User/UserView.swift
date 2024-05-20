//
//  UserView.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/16/24.
//

import UIKit

final class UserView: BaseView {
    
    private let profileLabel = UILabel().then {
        $0.text = "프로필"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    private let profileView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    var profileImage = UIImageView().then {
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 32
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    var userNameLabel = UILabel().then {
        $0.text = "사용자 이름"
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    var nickNameLabel = UILabel().then {
        $0.text = "사용자 닉네임"
        $0.font = UIFont.pretendard(size: 18, weight: .regular)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    
    private let dayGoalLabel = UILabel().then {
        $0.text = "일일 학습량"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    private let dayGoalView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    private let levelView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 17.5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.blue100.cgColor
    }
    
    private let levelLabel = UILabel().then {
        $0.text = "Lv. 1"
        $0.textColor = .blue100
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
    }
    
    private let dayGoalCountLabel = UILabel().then {
        $0.text = "일일 학습 단어 수"
        $0.font = UIFont.pretendard(size: 18, weight: .ultraLight)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let goalCountLabel = UILabel().then {
        $0.text = "60개"
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .right
    }
    
    private let levelProgressLabel = UILabel().then {
        $0.text = "레벨별 진도율"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    private let levelProgressView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    private let oneButton = UIButton().then {
        $0.setTitle("Lv. 1", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.layer.cornerRadius = 18
        $0.setTitleColor(.gray50, for: .normal)
        $0.backgroundColor = .blue10
    }
    
    private let twoButton = UIButton().then {
        $0.setTitle("Lv. 2", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.layer.cornerRadius = 18
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue25
    }
    
    private let threeButton = UIButton().then {
        $0.setTitle("Lv. 3", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.layer.cornerRadius = 18
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue50
    }
    
    private let fourButton = UIButton().then {
        $0.setTitle("Lv. 4", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.layer.cornerRadius = 18
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue75
    }
    
    private let fiveButton = UIButton().then {
        $0.setTitle("Lv. 5", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.layer.cornerRadius = 18
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue100
    }
    
    let oneProgressView = UIProgressView().then {
        $0.progress = 0.5
        $0.trackTintColor = .evBackground
        $0.progressTintColor = .blue10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.subviews[1].layer.borderWidth = 1
        $0.subviews[1].layer.borderColor = UIColor.gray50.cgColor
        $0.clipsToBounds = true
        $0.subviews[1].clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.sublayers?[1].cornerRadius = 15
    }
    
    let twoProgressView = UIProgressView().then {
        $0.progress = 0.5
        $0.trackTintColor = .evBackground
        $0.progressTintColor = .blue25
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.subviews[1].layer.borderWidth = 1
        $0.subviews[1].layer.borderColor = UIColor.gray50.cgColor
        $0.clipsToBounds = true
        $0.subviews[1].clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.sublayers?[1].cornerRadius = 15
    }
    
    let threeProgressView = UIProgressView().then {
        $0.progress = 0.5
        $0.trackTintColor = .evBackground
        $0.progressTintColor = .blue50
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.subviews[1].layer.borderWidth = 1
        $0.subviews[1].layer.borderColor = UIColor.gray50.cgColor
        $0.clipsToBounds = true
        $0.subviews[1].clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.sublayers?[1].cornerRadius = 15
    }
    
    let fourProgressView = UIProgressView().then {
        $0.progress = 0.5
        $0.trackTintColor = .evBackground
        $0.progressTintColor = .blue75
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.subviews[1].layer.borderWidth = 1
        $0.subviews[1].layer.borderColor = UIColor.gray50.cgColor
        $0.clipsToBounds = true
        $0.subviews[1].clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.sublayers?[1].cornerRadius = 15
    }
    
    let fiveProgressView = UIProgressView().then {
        $0.progress = 0.5
        $0.trackTintColor = .evBackground
        $0.progressTintColor = .blue100
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.subviews[1].layer.borderWidth = 1
        $0.subviews[1].layer.borderColor = UIColor.gray50.cgColor
        $0.clipsToBounds = true
        $0.subviews[1].clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.layer.sublayers?[1].cornerRadius = 15
    }
    
    let oneProgressPercentLabel = UILabel().then {
        $0.text = "50%"
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
        $0.textColor = .gray50
        $0.textAlignment = .right
    }
    
    let twoProgressPercentLabel = UILabel().then {
        $0.text = "50%"
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .right
    }
    
    let threeProgressPercentLabel = UILabel().then {
        $0.text = "50%"
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .right
    }
    
    let fourProgressPercentLabel = UILabel().then {
        $0.text = "50%"
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .right
    }
    
    let fiveProgressPercentLabel = UILabel().then {
        $0.text = "50%"
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .right
    }
    
    let modifyButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.tintColor = .gray50
    }
   
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
    }
    
    override func configureHierarchy() {
        [profileLabel,
         profileView,
         dayGoalLabel,
         dayGoalView,
         levelProgressLabel,
         levelProgressView].forEach { self.addSubview($0) }
        
        [profileImage,
         userNameLabel,
         nickNameLabel].forEach { profileView.addSubview($0) }
        
        [levelView,
         dayGoalCountLabel,
         goalCountLabel].forEach { dayGoalView.addSubview($0) }
        
        levelView.addSubview(levelLabel)
        
        [oneButton,
         twoButton,
         threeButton,
         fourButton,
         fiveButton,
         oneProgressView,
         twoProgressView,
         threeProgressView,
         fourProgressView,
         fiveProgressView].forEach { levelProgressView.addSubview($0) }
        
        oneProgressView.subviews[1].addSubview(oneProgressPercentLabel)
        twoProgressView.subviews[1].addSubview(twoProgressPercentLabel)
        threeProgressView.subviews[1].addSubview(threeProgressPercentLabel)
        fourProgressView.subviews[1].addSubview(fourProgressPercentLabel)
        fiveProgressView.subviews[1].addSubview(fiveProgressPercentLabel)
        
        
    }
    
    override func configureConstraints() {
        
        profileLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(profileLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
//            $0.height.equalTo(96)
        }
        
        dayGoalLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
        
        dayGoalView.snp.makeConstraints {
            $0.top.equalTo(dayGoalLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(55)
        }
        
        levelProgressLabel.snp.makeConstraints {
            $0.top.equalTo(dayGoalView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
        
        levelProgressView.snp.makeConstraints {
            $0.top.equalTo(levelProgressLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.width.equalTo(64)
            $0.height.equalTo(64)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.top).offset(4)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImage.snp.bottom).offset(-4)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
        }
        
        levelView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(87)
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        dayGoalCountLabel.snp.makeConstraints {
            $0.leading.equalTo(levelView.snp.trailing).offset(36)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        goalCountLabel.snp.makeConstraints {
            $0.leading.equalTo(dayGoalCountLabel.snp.trailing).offset(36)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        oneButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-266)
            $0.height.equalTo(36)
        }
        
        twoButton.snp.makeConstraints {
            $0.top.equalTo(oneButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-266)
            $0.height.equalTo(36)
        }
        
        threeButton.snp.makeConstraints {
            $0.top.equalTo(twoButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-266)
            $0.height.equalTo(36)
        }
        
        fourButton.snp.makeConstraints {
            $0.top.equalTo(threeButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-266)
            $0.height.equalTo(36)
        }
        
        fiveButton.snp.makeConstraints {
            $0.top.equalTo(fourButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-266)
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        }
        
        oneProgressView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalTo(oneButton.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(30)
        }
        
        twoProgressView.snp.makeConstraints {
            $0.centerY.equalTo(twoButton.snp.centerY)
            $0.leading.equalTo(twoButton.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(30)
        }
        
        threeProgressView.snp.makeConstraints {
            $0.centerY.equalTo(threeButton.snp.centerY)
            $0.leading.equalTo(threeButton.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(30)
        }
        
        fourProgressView.snp.makeConstraints {
            $0.centerY.equalTo(fourButton.snp.centerY)
            $0.leading.equalTo(fourButton.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(30)
        }
        
        fiveProgressView.snp.makeConstraints {
            $0.centerY.equalTo(fiveButton.snp.centerY)
            $0.leading.equalTo(fiveButton.snp.trailing).offset(18)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(30)
        }
        
        oneProgressPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        twoProgressPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        threeProgressPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        fourProgressPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        fiveProgressPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-6)
        }
      
        
    }
    

    
}

