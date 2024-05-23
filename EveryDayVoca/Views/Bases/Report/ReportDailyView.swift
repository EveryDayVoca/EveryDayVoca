//
//  ReportDailyView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/23/24.
//

import UIKit

class ReportDailyView: BaseView {
    
    // MARK: - Properties
    
    private let levelLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 14, weight: .medium)
    }
    
    private let difficultBar = UIView().then {
        $0.backgroundColor = UIColor.blue25
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    private let ambiguousBar = UIView().then {
        $0.backgroundColor = UIColor.blue50
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    private let memorizedBar = UIView().then {
        print("객체 생성")
        $0.backgroundColor = UIColor.blue100
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    private let difficultPercentLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.white
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
    }
    
    private let ambiguousPercentLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.white
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
    }
    
    private let memorizedPercentLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.white
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 13, weight: .semibold)
    }
    
    private let dateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
    }
    
    let yesterDayButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = UIColor.evText
    }
    
    let tomorrowButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = UIColor.evText
        
    }
    
    let vocaListTableView = UITableView().then {
        $0.backgroundColor = UIColor.evBackground
        $0.separatorStyle = .none
    }
    
    
    
    // MARK: - Methods
    
    override func configureHierarchy() {
        [levelLabel,
         difficultBar,
         ambiguousBar,
         memorizedBar,
         dateLabel,
         yesterDayButton,
         tomorrowButton,
         vocaListTableView].forEach{ self.addSubview($0) }
        
        difficultBar.addSubview(difficultPercentLabel)
        ambiguousBar.addSubview(ambiguousPercentLabel)
        memorizedBar.addSubview(memorizedPercentLabel)
        
    }
    
    
    override func configureConstraints() {
        
        let statusBarWidth = UIScreen.main.bounds.width - 52
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(17)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        difficultBar.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(17)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(statusBarWidth)
        }
        
        ambiguousBar.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(statusBarWidth)
        }
        
        memorizedBar.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(statusBarWidth)
        }
        
        difficultPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
        }
        
        ambiguousPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
        }
        
        memorizedPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(6)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(difficultBar.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        yesterDayButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(difficultBar)
            $0.size.equalTo(17)
        }
        
        tomorrowButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(difficultBar)
            $0.size.equalTo(17)
        }
        
        vocaListTableView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func bindLevelAndDateLabel(level: String, date: String) {
        levelLabel.text = level
        dateLabel.text = date
    }
    
    func bindstatusPercentLabel(difficult: Int, ambiguous: Int, memorized: Int) {
        difficultPercentLabel.text = "\(difficult)%"
        ambiguousPercentLabel.text = "\(ambiguous)%"
        memorizedPercentLabel.text = "\(memorized)%"
    }
    
    func reconfigureBarWidth(difficult: CGFloat, ambiguous: CGFloat, memorized: CGFloat) {
        difficultBar.snp.remakeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(difficult)
        }
        
        ambiguousBar.snp.remakeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(ambiguous)
        }
        
        memorizedBar.snp.remakeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(memorized)
        }
    }
    
    
}
