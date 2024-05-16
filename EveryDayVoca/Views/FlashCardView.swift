//
//  FlashCardView.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/16/24.
//

import UIKit

class FlashCardView: BaseView {
    
    // MARK: - properties
    private let progressRateLabel: UILabel = {
        var label = UILabel()
        label.text = "학습 진도율"
        label.font = UIFont.pretendard(size: 17, weight: .semibold)
        label.textColor = UIColor.evText
        label.textAlignment = .left
        return label
    }()
    
    var percentLabel: UILabel = {
        var label = UILabel()
        label.text = "50%"
        label.font = UIFont.pretendard(size: 13, weight: .semibold)
        label.textColor = UIColor.evBackground
        label.textAlignment = .center
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        var progress = UIProgressView(progressViewStyle: .default)
        progress.progress = 0.5
        progress.progressTintColor = .blue100
        progress.trackTintColor = .evBackground
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 10
        progress.subviews[1].clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 10
        progress.addSubview(percentLabel)
        return progress
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.evText.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        view.backgroundColor = .clear
        view.addSubview(progressBar)
        return view
    }()
    
    let cardImageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "flash_card")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var wordLabel: UILabel = {
        var label = UILabel()
        label.text = "Apple"
        label.textColor = .evText
        label.font = UIFont.pretendard(size: 24, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let previousCardButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "left_shift"), for: .normal)
        return button
    }()
    
    let nextCardButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "right_shift"), for: .normal)
        return button
    }()
    
    let hardButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.blue25
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .light),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "어려워요", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let normalButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.blue25
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .light),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "애매해요", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let perfectButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.blue100
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .semibold),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "외웠어요", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [hardButton, normalButton, perfectButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        self.addSubview(progressRateLabel)
        self.addSubview(containerView)
        self.addSubview(cardImageView)
        self.addSubview(wordLabel)
        self.addSubview(previousCardButton)
        self.addSubview(nextCardButton)
        self.addSubview(buttonStack)
    }
    
    override func configureConstraints() {
        progressRateLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(28)
        }
        
        percentLabel.snp.makeConstraints {
            $0.trailing.equalTo(progressBar.subviews[1].snp.trailing).inset(8)
            $0.top.equalTo(progressBar.subviews[1].snp.top)
            $0.bottom.equalTo(progressBar.subviews[1].snp.bottom)
        }
        
        progressBar.snp.makeConstraints {
            $0.edges.equalTo(containerView.snp.edges)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(self.progressRateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalToSuperview().multipliedBy(0.028)
        }
        
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(cardImageView.snp.height)
            $0.width.equalToSuperview().multipliedBy(0.78)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        wordLabel.snp.makeConstraints {
            $0.edges.equalTo(cardImageView.snp.edges)
        }
        
        previousCardButton.snp.makeConstraints {
            $0.trailing.equalTo(cardImageView.snp.leading)
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(cardImageView.snp.top)
            $0.bottom.equalTo(cardImageView.snp.bottom)
        }
        
        nextCardButton.snp.makeConstraints {
            $0.leading.equalTo(cardImageView.snp.trailing)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(cardImageView.snp.top)
            $0.bottom.equalTo(cardImageView.snp.bottom)
        }
        
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.equalTo(cardImageView.snp.bottom).offset(96)
            $0.height.equalToSuperview().multipliedBy(0.067)
        }
    }
}
