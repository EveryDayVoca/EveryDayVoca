//
//  UserModifyView.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/22/24.
//

import UIKit

final class UserModifyView: BaseView {
    
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
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            $0.image = image
        }
    }
    
    private let imageModifyButton = UIButton().then {
        $0.setTitle("프로필 사진 수정", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 14, weight: .medium)
        $0.setTitleColor(.gray100, for: .normal)
    }
    
    private let userNameLabel = UILabel().then {
        $0.text = "사용자 이름"
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    private let nickNameLabel = UILabel().then {
        $0.text = "사용자 닉네임"
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let changeNameTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 32))
        $0.backgroundColor = .gray25
        $0.layer.cornerRadius = 16
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .evText
        $0.text = UserDefaultsManager.shared.getValue(key: "userName")
    }
    
    let changeNickNameTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 32))
        $0.backgroundColor = .gray25
        $0.layer.cornerRadius = 16
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .evText
        $0.text = UserDefaultsManager.shared.getValue(key: "userNickName")
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
    
    private let levelLabel = UILabel().then {
        $0.text = "레벨"
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    private let learningAmountLabel = UILabel().then {
        $0.text = "일일 학습량"
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    let levelTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 32))
        $0.backgroundColor = .gray25
        $0.layer.cornerRadius = 16
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .clear
        $0.text = UserDefaultsManager.shared.getValue(key: "studyLevel")
    }
    
    let learningAmountTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 32))
        $0.backgroundColor = .gray25
        $0.layer.cornerRadius = 16
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.tintColor = .clear
        $0.text = UserDefaultsManager.shared.getValue(key: "studyAmount")
    }
    
    let doneEditButton = UIButton().then {
        $0.setTitle("변경 사항 저장", for: .normal)
        $0.backgroundColor = .blue100
        $0.tintColor = .white
        $0.layer.cornerRadius = 15
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        
        [profileLabel,
         profileView,
         dayGoalLabel,
         dayGoalView,
         doneEditButton].forEach { self.addSubview($0) }
        
        [profileImage,
         imageModifyButton,
         userNameLabel,
         nickNameLabel,
         changeNameTextField,
         changeNickNameTextField].forEach { profileView.addSubview($0) }
        
        [levelLabel,
         learningAmountLabel,
         levelTextField,
         learningAmountTextField].forEach { dayGoalView.addSubview($0) }
        
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
            $0.height.equalTo(217)
        }
        
        dayGoalLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
        
        dayGoalView.snp.makeConstraints {
            $0.top.equalTo(dayGoalLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(106)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(64)
            $0.height.equalTo(64)
        }
        
        imageModifyButton.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(8)
            $0.centerX.equalTo(profileImage)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageModifyButton.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-248)
        }
        
        nickNameLabel.snp.makeConstraints{
            $0.centerY.equalTo(changeNickNameTextField)
            $0.leading.equalToSuperview().offset(16)
        }
        
        changeNameTextField.snp.makeConstraints{
            $0.centerY.equalTo(userNameLabel)
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(32)
        }
        
        changeNickNameTextField.snp.makeConstraints{
            $0.top.equalTo(changeNameTextField.snp.bottom).offset(12)
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(32)
        }
        
        levelLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        learningAmountLabel.snp.makeConstraints{
            $0.top.equalTo(levelLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        levelTextField.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel.snp.centerY)
            $0.height.equalTo(32)
            $0.width.equalTo(changeNameTextField)
            $0.centerX.equalTo(changeNameTextField)
        }
        
        learningAmountTextField.snp.makeConstraints {
            $0.centerY.equalTo(learningAmountLabel.snp.centerY)
            $0.height.equalTo(32)
            $0.width.equalTo(changeNameTextField)
            $0.centerX.equalTo(changeNameTextField)
        }
        
        doneEditButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(56)
        }
    }
}
