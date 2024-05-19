//
//  FlashCardView.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/16/24.
//

import UIKit
import Shuffle

final class FlashCardView: BaseView {
    
    // MARK: - Properties
    
    private let progressRateLabel = UILabel().then {
        $0.text = "학습 진도율"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
    }
    
    private lazy var containerView = UIView().then {
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 10
        $0.backgroundColor = .clear
    }
    
    lazy var progressBar = UIProgressView(progressViewStyle: .default).then {
        $0.progress = 0.5
        $0.progressTintColor = .blue100
        $0.trackTintColor = .evBackground
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.subviews[1].clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 10
    }
    
    var percentLabel = UILabel().then {
        $0.text = "50%"
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
        $0.textColor = UIColor.evBackground
        $0.textAlignment = .center
    }
    
    let cardStack = SwipeCardStack()
    
    let hardButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .light),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "어려워요", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.blue25
    }
    
    let normalButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .light),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "애매해요", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.blue25
    }
    
    let perfectButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .semibold),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "외웠어요", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.blue100
    }
    
    private lazy var buttonStack = UIStackView(arrangedSubviews: [hardButton, normalButton, perfectButton]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    
    // MARK: - Methods
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        self.addSubview(progressRateLabel)
        self.addSubview(containerView)
        containerView.addSubview(progressBar)
        progressBar.addSubview(percentLabel)
        self.addSubview(cardStack)
        self.addSubview(buttonStack)
    }
    
    override func configureConstraints() {
        progressRateLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(self.progressRateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalToSuperview().multipliedBy(0.028)
        }
        
        progressBar.snp.makeConstraints {
            $0.edges.equalTo(containerView.snp.edges)
        }
        
        percentLabel.snp.makeConstraints {
            $0.trailing.equalTo(progressBar.subviews[1].snp.trailing).inset(8)
            $0.top.equalTo(progressBar.subviews[1].snp.top)
            $0.bottom.equalTo(progressBar.subviews[1].snp.bottom)
        }
        
        cardStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.width.equalTo(cardStack.snp.height)
        }
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(100)
            $0.height.equalToSuperview().multipliedBy(0.067)
        }
    }
}
