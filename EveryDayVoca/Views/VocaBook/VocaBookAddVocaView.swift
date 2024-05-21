//
//  VocaBookAddVocaView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class VocaBookAddVocaView: BaseView {
    
    // MARK: - Properties
    
    var vocaBooks: [String] = ["나의 단어장", "고등 영단어"]
    
    let titleLabel = UILabel().then {
        $0.text = "단어 추가하기"
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
    }
    
    let koreanTextFieldTitleLabel = UILabel().then {
        $0.text = "단어:"
        $0.textAlignment = .right
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 17, weight: .medium)
    }
    
    let englishTextFieldTitleLabel = UILabel().then {
        $0.text = "의미:"
        $0.textAlignment = .right
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 17, weight: .medium)
    }
    
    let vocaBookSelectPopupButtonTitleLabel = UILabel().then {
        $0.text = "단어장:"
        $0.textAlignment = .right
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 17, weight: .regular)
    }
    
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.pretendard(size: 17, weight: .regular),
        .foregroundColor: UIColor.gray50,
        .underlineStyle: 0]
    
    lazy var englishTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "영단어 입력하기", attributes: attributes)
    }
    
    lazy var koreanTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "뜻 입력하기", attributes: attributes)
    }
    
    let vocaBookSelectView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
    }
    
    lazy var vocaBookSelectPopupButton = UIButton().then {
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle?.font = UIFont.pretendard(size: 17, weight: .regular)
        config.baseForegroundColor = UIColor.evText
        config.baseBackgroundColor = UIColor.evBackground
        config.background.strokeColor = UIColor.gray50
        config.background.cornerRadius = 20
        config.background.strokeWidth = 1
        $0.configuration = config
        
        $0.menu = vocaBookButtonMenu
        $0.showsMenuAsPrimaryAction = true
        $0.changesSelectionAsPrimaryAction = true
        $0.preferredBehavioralStyle = .automatic
    }
    
    lazy var vocaBookButtonMenu = { [self] in
        var actionArray: [UIAction] = []
        vocaBooks.forEach {
            actionArray.append(makeUIAction(title: $0))
        }
        let buttonMenu = UIMenu(title: "단어장 선택", children: actionArray)
        return buttonMenu
    }()
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy var cancelButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "취소하기", fgColor: UIColor.blue100, bgColor: UIColor.evBackground, isBordered: true)
    )
    
    lazy var addButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "추가하기", fgColor: UIColor.evBackground, bgColor: UIColor.blue100, isBordered: false)
    )
    
    
    
    // MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
        configureTextField()
    }
    
    override func configureHierarchy() { 
        super.configureHierarchy()
        
        [titleLabel,
         englishTextFieldTitleLabel,
         koreanTextFieldTitleLabel,
         vocaBookSelectPopupButtonTitleLabel,
         englishTextField,
         koreanTextField,
         vocaBookSelectPopupButton,
         buttonStackView].forEach { self.addSubview($0) }
        
        [cancelButton,
         addButton].forEach { buttonStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() { 
        super.configureConstraints()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(30)
            $0.centerX.equalTo(self)
        }
        
        englishTextFieldTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(self).offset(20)
            $0.height.equalTo(44)
            $0.width.equalTo(52)
        }
        
        koreanTextFieldTitleLabel.snp.makeConstraints {
            $0.top.equalTo(englishTextFieldTitleLabel.snp.bottom).offset(24)
            $0.leading.equalTo(self).offset(20)
            $0.height.equalTo(44)
            $0.width.equalTo(52)
        }
        
        vocaBookSelectPopupButtonTitleLabel.snp.makeConstraints {
            $0.top.equalTo(koreanTextFieldTitleLabel.snp.bottom).offset(24)
            $0.leading.equalTo(self).offset(20)
            $0.height.equalTo(44)
            $0.width.equalTo(52)
        }
        
        englishTextField.snp.makeConstraints {
            $0.centerY.equalTo(englishTextFieldTitleLabel)
            $0.leading.equalTo(englishTextFieldTitleLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        koreanTextField.snp.makeConstraints {
            $0.centerY.equalTo(koreanTextFieldTitleLabel)
            $0.leading.equalTo(koreanTextFieldTitleLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        vocaBookSelectPopupButton.snp.makeConstraints {
            $0.centerY.equalTo(vocaBookSelectPopupButtonTitleLabel)
            $0.leading.equalTo(vocaBookSelectPopupButtonTitleLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(vocaBookSelectPopupButtonTitleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(self).inset(44)
            $0.height.equalTo(44)
        }
    }

    
    
    private func makeUIAction(title: String) -> UIAction {
        return UIAction(title: title, handler: { _ in print(title) })
    }
    
    private func returnButtonConfiguration(title: String, fgColor: UIColor, bgColor: UIColor, isBordered: Bool) -> UIButton.Configuration {
        
        
        var config = UIButton.Configuration.plain()
        // title
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.font = UIFont.pretendard(size: 20, weight: .semibold)
        // color
        config.baseForegroundColor = fgColor
        config.background.backgroundColor = bgColor
        // frame
        config.background.cornerRadius = 15
        if isBordered {
            config.background.strokeWidth = 1
            config.background.strokeColor = UIColor.blue100
        }
        return config
    }
    
    func configureTextField() {
        [englishTextField,
         koreanTextField].forEach {
            // 1. 디자인
            $0.backgroundColor = UIColor.evBackground
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray50.cgColor
            $0.textColor = UIColor.evText
            
            // 2. 좌우 여백
            $0.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 0))
            $0.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 0))
            $0.leftViewMode = .always
            $0.rightViewMode = .always
            
            // 3. 입력 설정
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.spellCheckingType = .yes
        }
    }
    
    
}
