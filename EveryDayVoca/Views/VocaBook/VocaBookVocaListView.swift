//
//  VocaBookVocaListView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/16/24.
//

import UIKit

final class VocaBookVocaListView: BaseView {
    
    // MARK: - Properties
    
    let vocaBookSelectionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    let vocaBookSelectionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    let vocaBookSelectionImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.evText
    }
    
    let tableOptionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    let tableFilterButton = UIButton().then {
        $0.setTitle("모든단어", for: .normal)
        $0.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
        $0.backgroundColor = UIColor.blue100
        $0.tintColor = UIColor.evText
    }
    
    let tableDisplayOptionButton = UIButton().then {
        $0.setTitle("단어 + 의미", for: .normal)
        $0.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
        $0.backgroundColor = UIColor.blue100
        $0.tintColor = UIColor.evText
    }
    
    let tableItemCountLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.gray100
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    let vocaListTableView = UITableView().then {
        $0.backgroundColor = UIColor.evBackground
    }
    
    // MARK: - Methods
    
    override func configureConstraints() {
        vocaBookSelectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        vocaBookSelectionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        vocaBookSelectionImage.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
        }
        
        tableOptionView.snp.makeConstraints {
            $0.top.equalTo(vocaBookSelectionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(vocaListTableView)
            $0.height.equalTo(25)
        }
        
        tableFilterButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.width.equalTo(91)
        }
        
        tableDisplayOptionButton.snp.makeConstraints {
            $0.leading.equalTo(tableFilterButton.snp.trailing).offset(10)
            $0.verticalEdges.equalToSuperview()
            $0.width.equalTo(96)
        }
        
        tableItemCountLabel.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        vocaListTableView.snp.makeConstraints {
            $0.top.equalTo(tableOptionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configureHierarchy() {
        [vocaBookSelectionView,
         tableOptionView,
         vocaListTableView].forEach { self.addSubview($0) }
        
        [vocaBookSelectionLabel,
         vocaBookSelectionImage].forEach { vocaBookSelectionView.addSubview($0) }
        
        [tableFilterButton,
         tableDisplayOptionButton,
         tableItemCountLabel].forEach { tableOptionView.addSubview($0) }
        
    }
    
}
