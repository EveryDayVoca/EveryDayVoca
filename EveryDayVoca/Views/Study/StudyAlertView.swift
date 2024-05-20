//
//  StudyAlertView.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/20/24.
//

import UIKit

final class StudyAlertView: BaseView {
    
    // MARK: - properties
    private let backgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "단어장 추가하기"
        $0.textColor = .evText
        $0.textAlignment = .center
        $0.font = UIFont.pretendard(size: 20, weight: .semibold)
        $0.numberOfLines = 0
    }
    
    let messageTextField = UITextField().then {
        $0.backgroundColor = .gray25
        $0.layer.cornerRadius = 15
    }
    
    let cancelButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .semibold),
                                                         .foregroundColor: UIColor.blue100]
        let attributedTitle = NSAttributedString(string: "취소하기", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.blue100.cgColor
    }
    
    let addButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .semibold),
                                                         .foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: "추가하기", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.backgroundColor = .blue100
        $0.layer.cornerRadius = 12
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 14
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        messageTextField.addPadding()
    }
    
    override func configureHierarchy() {
        self.addSubview(backgroundView)
        self.backgroundView.addSubview(containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(messageTextField)
        self.containerView.addSubview(buttonStackView)
        self.buttonStackView.addArrangedSubview(cancelButton)
        self.buttonStackView.addArrangedSubview(addButton)
    }
    
    override func configureConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(-30)
            $0.width.equalToSuperview().multipliedBy(0.90)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        messageTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(messageTextField.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(45)
        }
    }
}

extension UITextField {
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
