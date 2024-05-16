//
//  UserView.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/16/24.
//

import UIKit

final class UserView: BaseView {
    
    let profileLabel = UILabel().then {
        $0.text = "프로필"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let profileView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let profileImage = UIImageView().then {
        $0.backgroundColor = .gray100
        $0.layer.cornerRadius = $0.frame.height/2
    }
    
    let userNameLabel = UILabel().then {
        $0.text = "데일리보카"
        $0.font = UIFont.pretendard(size: 18, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let nickNameLabel = UILabel().then {
        $0.text = "임시"
        $0.font = UIFont.pretendard(size: 18, weight: .regular)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    
    let dayGoalLabel = UILabel().then {
        $0.text = "일일 학습량"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let dayGoalView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let levelButton = UIButton().then {
        $0.titleLabel?.text = "Lv.1"
        $0.titleLabel?.textColor = UIColor.blue100
        $0.titleLabel?.font = UIFont.pretendard(size: 18, weight: .regular)
        $0.layer.cornerRadius = 20
    }
    
    let dayGoalCountLabel = UILabel().then {
        $0.text = "일일 학습 단어 수"
        $0.font = UIFont.pretendard(size: 18, weight: .regular)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let goalCountLabel = UILabel().then {
        $0.text = "일일 학습 단어 수"
        $0.font = UIFont.pretendard(size: 18, weight: .regular)
        $0.textColor = UIColor.evText
        $0.textAlignment = .right
    }
    
    let levelProgressLabel = UILabel().then {
        $0.text = "레벨별 진도율"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let levelProgressView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let oneButton = UIButton().then
    let twoButton = UIButton().then
    let threeButton = UIButton().then
    let fourButton = UIButton().then
    let fiveButton = UIButton().then
    
    let oneProgressView = UIProgressView().then
    let twoProgressView = UIProgressView().then
    let threeProgressView = UIProgressView().then
    let fourProgressView = UIProgressView().then
    let fiveProgressView = UIProgressView().then
    
    
    
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
        
        [levelButton,
         dayGoalCountLabel,
         goalCountLabel].forEach { dayGoalView.addSubview($0) }
        
        [].forEach { levelProgressView.addSubview($0) }
        
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
            $0.height.equalTo(96)
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
        
        levelButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(87)
            $0.height.equalTo(35)
        }
    }

    
}

