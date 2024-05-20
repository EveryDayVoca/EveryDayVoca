//
//  MyVocaFlashCardView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class MyVocaFlashCardView: VocaBookBaseView {
    
    
    // 임시-------------------------------
    var vocas: [Voca] = [
        Voca(english: "apple", korean: "사과", pronunciation: "ˈæpl", status: .memorized, vocaBook: "초등"),
        Voca(english: "acid", korean: "산", pronunciation: "ˈæsɪd", status: .memorized, vocaBook: "중고등"),
        Voca(english: "absorb", korean: "흡수하다", pronunciation: "əb|sɔːrb", status: .ambiguous, vocaBook: "중고등"),
        Voca(english: "delicate", korean: "미묘한", pronunciation: "ˈdelɪkət", status: .difficult, vocaBook: "중고등")
    ]
    // ----------------------------------
    
    
    // MARK: - Properties
    
    private lazy var statusButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
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
    
    private let cardStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 26
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private let englishCardView = UIView().then {
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 16
        $0.backgroundColor = UIColor.evBackground
    }
    
    private let englishLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private let englishLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
    }
    
    private let englishPronunciationLabel = UILabel().then {
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
    
    let pagingButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
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
        
        [statusButtonStackView, 
         cardStackView,
        pagingButtonStackView].forEach { self.customView.addSubview($0) }
        
        [hardButton, 
         ambiguousButton,
         memorizedButton].forEach { statusButtonStackView.addArrangedSubview($0) }
        
        [englishCardView,
         koreanCardView].forEach { cardStackView.addArrangedSubview($0) }
        
        englishCardView.addSubview(englishLabelStackView)
        
        [englishLabel,
         englishPronunciationLabel].forEach { englishLabelStackView.addArrangedSubview($0) }
        
        koreanCardView.addSubview(koreanLabel)
        
        [previousPageButton,
         nextPageButton].forEach { pagingButtonStackView.addArrangedSubview($0) }
        
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        statusButtonStackView.snp.makeConstraints {
            $0.top.equalTo(customView).offset(16)
            $0.horizontalEdges.equalTo(customView).inset(24)
            $0.height.equalTo(56)
        }

        cardStackView.snp.makeConstraints {
            $0.top.equalTo(statusButtonStackView.snp.bottom).offset(28)
            $0.horizontalEdges.equalTo(statusButtonStackView)
        }
        
        pagingButtonStackView.snp.makeConstraints {
            $0.top.equalTo(cardStackView.snp.bottom).offset(104)
            $0.horizontalEdges.equalTo(statusButtonStackView)
            $0.bottom.equalTo(customView)
            $0.height.equalTo(56)
        }
        
        englishLabelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
        koreanLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
    }
    
    func bind(index: Int) {
        englishLabel.text = vocas[index].english
        englishPronunciationLabel.text = vocas[index].pronunciation
        koreanLabel.text = vocas[index].korean
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
