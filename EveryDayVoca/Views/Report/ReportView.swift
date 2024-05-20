//
//  ReportView.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/19/24.
//

import UIKit

class ReportView: BaseView {
    
    private let monthRateLabel = UILabel().then {
        $0.text = "이번 달 학습량"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textAlignment = .left
    }
    
    private let monthRateView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    private let blue100DotImage = UIImageView().then {
        $0.backgroundColor = .blue100
        $0.layer.cornerRadius = 5
    }
    
    private let blue50DotImage = UIImageView().then {
        $0.backgroundColor = .blue50
        $0.layer.cornerRadius = 5
    }
    
    private let blue10DotImage = UIImageView().then {
        $0.backgroundColor = .blue10
        $0.layer.cornerRadius = 5
    }
    
    let blue100Label = UILabel().then {
        $0.text = "20개"
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .right
    }
    
    let blue50Label = UILabel().then {
        $0.text = "8개"
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .right
    }
    
    let blue10Label = UILabel().then {
        $0.text = "12개"
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .right
    }
    
    private let rateLabel = UILabel().then {
        $0.text = "출석률"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .center
    }
    
    let ratePercentLabel = UILabel().then {
        $0.text = "100%"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .center
    }
    
    private let countLabel = UILabel().then {
        $0.text = "외운 단어 수"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .center
    }
    
    let countNumberLabel = UILabel().then {
        $0.text = "35개"
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .evText
        $0.textAlignment = .center
    }
    
    private let calendarView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let calendar = UICalendarView().then {
        $0.wantsDateDecorations = true
    }
    
    override func configureUI() {
        super.configureUI()
    }

    override func configureHierarchy() {
        [monthRateLabel,
         monthRateView,
         calendarView].forEach { self.addSubview($0) }
        
        [blue100DotImage,
         blue50DotImage,
         blue10DotImage,
         blue100Label,
         blue50Label,
         blue10Label,
         rateLabel,
         ratePercentLabel,
         countLabel,
         countNumberLabel].forEach { monthRateView.addSubview($0) }
        
        calendarView.addSubview(calendar)
    }
    
    override func configureConstraints() {
        monthRateLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        monthRateView.snp.makeConstraints {
            $0.top.equalTo(monthRateLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(84)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(monthRateView.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        rateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(184)
        }
        
        ratePercentLabel.snp.makeConstraints { 
            $0.top.equalTo(rateLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(rateLabel)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalTo(rateLabel.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        countNumberLabel.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(countLabel)
        }
        
        blue100DotImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(107)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        
        blue50DotImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.leading.equalToSuperview().offset(107)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        
        blue10DotImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(107)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        
        blue100Label.snp.makeConstraints {
            $0.centerY.equalTo(blue100DotImage)
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-24)
        }
        
        blue50Label.snp.makeConstraints {
            $0.centerY.equalTo(blue50DotImage)
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-24)
        }
        
        blue10Label.snp.makeConstraints {
            $0.centerY.equalTo(blue10DotImage)
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-24)
        }
    }
    
}
