//
//  SecondView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/23/24.
//

import UIKit

class SecondView: BaseView {
    
    // MARK: - Properties
    
    let levelTitle = UILabel().then {
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
        $0.backgroundColor = UIColor.blue10
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    
    
    // MARK: - Methods
    
    override func configureHierarchy() {
        [levelTitle,
         difficultBar,
         ambiguousBar,
         memorizedBar].forEach{ self.addSubview($0) }
    }
    
    
    override func configureConstraints() {
        
        let statusBarWidth = UIScreen.main.bounds.width - 52
        
        levelTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        difficultBar.snp.makeConstraints {
            $0.top.equalTo(levelTitle.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(statusBarWidth)
        }
        
        ambiguousBar.snp.makeConstraints {
            $0.top.equalTo(levelTitle.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(statusBarWidth)
        }
        
        memorizedBar.snp.makeConstraints {
            $0.top.equalTo(levelTitle.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(statusBarWidth)
        }
    }
    
    
    func reConfigureStatusBar(difficult: Int, ambiguous: Int, memorized: Int) {
        
        let statusBarWidth = UIScreen.main.bounds.width - 52
        
        let total = CGFloat(difficult + ambiguous + memorized)
        
        let difficultSpace = CGFloat(difficult) / total * statusBarWidth
        let ambiguousSpace = CGFloat(ambiguous) / total * statusBarWidth
        let memorizedSpace = CGFloat(memorized) / total * statusBarWidth
        
        let difficultBarWidth = statusBarWidth
        let ambiguousBarWidth = memorizedSpace + ambiguousSpace
        let memorizedBarWidth = memorizedSpace
        
        
        difficultBar.snp.remakeConstraints {
            $0.top.equalTo(levelTitle.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(difficultBarWidth)
        }
        
        ambiguousBar.snp.remakeConstraints {
            $0.top.equalTo(levelTitle.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(ambiguousBarWidth)
        }
        
        memorizedBar.snp.remakeConstraints {
            $0.top.equalTo(levelTitle.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(26)
            $0.width.equalTo(memorizedBarWidth)
        }
        
        
    }
    
    
}
