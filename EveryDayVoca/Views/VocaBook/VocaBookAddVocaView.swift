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
    
    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 17, weight: .regular),
                                                             .foregroundColor: UIColor.gray50,
                                                             .underlineStyle: 0]
    
    lazy var englishTextField = UITextField().then {
        $0.backgroundColor = UIColor.evBackground
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.textColor = UIColor.evText
        $0.attributedPlaceholder = NSAttributedString(string: "영단어 입력하기", attributes: attributes)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .yes
    }
    
    lazy var koreanTextField = UITextField().then {
        $0.backgroundColor = UIColor.evBackground
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.textColor = UIColor.evText
        $0.attributedPlaceholder = NSAttributedString(string: "뜻 입력하기", attributes: attributes)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .yes
    }
    
    lazy var vocaBookSelectPopupButton = UIButton().then {
        $0.backgroundColor = UIColor.evBackground
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.setTitle("단어장 선택하기", for: .normal)
        $0.setTitleColor(UIColor.evText, for: .normal)
        $0.showsMenuAsPrimaryAction = true
        $0.changesSelectionAsPrimaryAction = true
        $0.menu = vocaBookButtonMenu
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
    
    override func configureHierarchy() { 
        super.configureHierarchy()
        
        [titleLabel,
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
        
        englishTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        
        koreanTextField.snp.makeConstraints {
            $0.top.equalTo(englishTextField.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(englishTextField)
            $0.height.equalTo(44)
        }
        
        vocaBookSelectPopupButton.snp.makeConstraints {
            $0.top.equalTo(koreanTextField.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(koreanTextField)
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
    
    
}
