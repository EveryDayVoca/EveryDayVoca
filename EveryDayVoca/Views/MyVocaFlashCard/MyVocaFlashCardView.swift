//
//  MyVocaFlashCardView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class MyVocaFlashCardView: VocaBookBaseView {
    
    // MARK: - Properties
    
    lazy var hardButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "어려워요", fgColor: UIColor.evBackground, bgColor: UIColor.blue25)
    )
    
    lazy var ambiguousButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "애매해요", fgColor: UIColor.evBackground, bgColor: UIColor.blue25)
    )
    
    lazy var memorizedButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "외웠어요", fgColor: UIColor.evBackground, bgColor: UIColor.blue25)
    )
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private let englishCardView = UIView().then {
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 16
        $0.backgroundColor = UIColor.evBackground
    }
    
    private let englishLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
    }
    
    private let pronunciationLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.gray50
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 18, weight: .regular)
    }
    
    private let koreanCardView = UIView().then {
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 16
        $0.backgroundColor = .clear
    }
    
    private let koreanLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
    }
    
    private let cardStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 25
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy var previousPageButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "이전 단어", fgColor: UIColor.evBackground, bgColor: UIColor.blue100)
    )
    
    lazy var nextPageButton = UIButton(
        configuration:
            returnButtonConfiguration(
                title: "다음 단어", fgColor: UIColor.blue100, bgColor: UIColor.evBackground)
    )
    
    
    let pageControlStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() { 
        super.configureHierarchy()
        
        [buttonStackView, 
         cardStackView,
        pageControlStackView].forEach { self.customView.addSubview($0) }
        
        [hardButton, 
         ambiguousButton,
         memorizedButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        [englishCardView,
         koreanCardView].forEach { cardStackView.addArrangedSubview($0) }
        
        [englishLabel,
         pronunciationLabel].forEach { englishCardView.addSubview($0) }
        
        koreanCardView.addSubview(koreanLabel)
        
        [previousPageButton,
         nextPageButton].forEach { pageControlStackView.addArrangedSubview($0) }
        
    }
    
    override func configureConstraints() {
        super.configureConstraints()
    }
    
    
    
    private func returnButtonConfiguration(title: String, fgColor: UIColor, bgColor: UIColor) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        // title
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.font = UIFont.pretendard(size: 20, weight: .semibold)
        // color
        config.baseForegroundColor = fgColor
        config.background.backgroundColor = bgColor
        // frame
        config.background.cornerRadius = 15
        return config
    }
    
}
