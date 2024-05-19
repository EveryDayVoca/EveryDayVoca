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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
}
