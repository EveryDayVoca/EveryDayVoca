//
//  CardView.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/19/24.
//

import UIKit
import Shuffle

final class CardView: SwipeCard {
    
    // MARK: - properties
    var dataModel: Voca?
    private var isWordPage = true
    
    private let cardImageView = UIImageView().then {
        $0.image = UIImage(named: "flash_card")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    var wordLabel = UILabel().then {
        $0.textColor = UIColor.evText
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.text = "메롱"
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    
    // MARK: - methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
        configureHierarchy()
        configureConstraints()
        configureTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with data: Voca) {
        dataModel = data
        wordLabel.text = data.english
    }
    
    func configureHierarchy() {
        self.addSubview(cardImageView)
        self.addSubview(wordLabel)
    }
    
    func configureConstraints() {
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wordLabel.snp.makeConstraints {
            $0.edges.equalTo(cardImageView.snp.edges)
        }
    }
    
    func configureTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tappedCard() {
        guard let data = dataModel else { return }
        isWordPage.toggle()
        wordLabel.text = isWordPage ? data.english : data.korean
        UIView.transition(with: self,
                            duration: 0.3,
                            options: .transitionFlipFromLeft,
                            animations: nil,
                            completion: nil)
    }
}
