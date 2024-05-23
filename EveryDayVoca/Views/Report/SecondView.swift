//
//  SecondView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/23/24.
//

import UIKit

class SecondView: BaseView {
    
    // MARK: - Properties
    
    let levelLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 14, weight: .medium)
    }
    
    let difficultBar = UIView().then {
        $0.backgroundColor = UIColor.blue10
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let ambiguousBar = UIView().then {
        $0.backgroundColor = UIColor.blue10
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let memorizedBar = UIView().then {
        print("객체 생성")
        $0.backgroundColor = UIColor.blue10
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    let dateLabel = UILabel().then {
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
    }
    
    
    override func configureConstraints() {
        
        let statusBarWidth = UIScreen.main.bounds.width - 52
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        difficultBar.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
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
            $0.horizontalEdges.equalTo(difficultBar)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    func remakeConstraints(difficult: Int, ambiguous: Int, memorized: Int) {
        print("reConfigure")
        let statusBarWidth = UIScreen.main.bounds.width - 52
        
        let total = CGFloat(difficult + ambiguous + memorized)
        
        let difficultSpace = CGFloat(difficult) / total * statusBarWidth
        let ambiguousSpace = CGFloat(ambiguous) / total * statusBarWidth
        let memorizedSpace = CGFloat(memorized) / total * statusBarWidth
        
        let difficultBarWidth = statusBarWidth
        let ambiguousBarWidth = memorizedSpace + ambiguousSpace
        let memorizedBarWidth = memorizedSpace
        
        
        difficultBar.snp.remakeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(difficultBarWidth)
        }
        
        ambiguousBar.snp.remakeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(ambiguousBarWidth)
        }
        
        memorizedBar.snp.remakeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.height.equalTo(25)
            $0.width.equalTo(memorizedBarWidth)
        }
        
        
    }
    
    
}
