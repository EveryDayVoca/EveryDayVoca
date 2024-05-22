//
//  MyVocaFlashCardView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class MyVocaFlashCardView: VocaBookBaseView {
//    
//    var vocas: [Voca] = []
//    
    var currentVoca: Voca? {
        didSet {
            updateButtonConfiguration()
        }
    }
    
    // MARK: - Properties
    
    private lazy var statusButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    
    let difficultButton = UIButton()
    
    let ambiguousButton = UIButton()
    
    let memorizedButton = UIButton()
    
    private let cardStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 26
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    private let englishCardView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 8
        $0.backgroundColor = UIColor.evBackground
    }
    
    private let koreanCardView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 8
        $0.backgroundColor = UIColor.evBackground
    }
    
    private let englishLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
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
            returnPagingButtonConfiguration(
                title: "이전 단어", fgColor: UIColor.blue100, bgColor: UIColor.evBackground, isBordered: true)
    )
    
    lazy var nextPageButton = UIButton(
        configuration:
            returnPagingButtonConfiguration(
                title: "다음 단어", fgColor: UIColor.evBackground, bgColor: UIColor.blue100, isBordered: false)
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
        
        [difficultButton, 
         ambiguousButton,
         memorizedButton].forEach { statusButtonStackView.addArrangedSubview($0) }
        
        [englishCardView,
         koreanCardView].forEach { cardStackView.addArrangedSubview($0) }
        
        englishCardView.addSubview(englishLabel)
        
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
        
        englishLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
        koreanLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
    }
    
    func bind(voca: Voca) {
        currentVoca = voca
        currentVocaBookLabel.text = currentVoca?.vocaDeck
        englishLabel.text = currentVoca?.english
        koreanLabel.text = currentVoca?.korean
    }
    
    func updateButtonConfiguration() {
        difficultButton.configuration = returnStatusButtonConfiguration(title: "어려워요")
        
        ambiguousButton.configuration = returnStatusButtonConfiguration(
            title: "애매해요")

        memorizedButton.configuration = returnStatusButtonConfiguration(
            title: "외웠어요")
    }
    
    private func returnStatusButtonConfiguration(title: String) -> UIButton.Configuration {
        
        let isSelected = title == currentVoca?.status
        print("isSelected: \(title) == \(currentVoca?.status)? -> \(isSelected)")
        
        var config = UIButton.Configuration.plain()
        // title
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.font = UIFont.pretendard(size: 20, weight: .semibold)
        // frame
        config.background.cornerRadius = 15
        // color
        if isSelected {
            config.baseForegroundColor = UIColor.evBackground
            config.background.backgroundColor = UIColor.blue100
        } else {
            config.baseForegroundColor = UIColor.evBackground
            config.background.backgroundColor = UIColor.blue25
        }
        return config
    }
    
    private func returnPagingButtonConfiguration(title: String, fgColor: UIColor, bgColor: UIColor, isBordered: Bool) -> UIButton.Configuration {
        
        
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
