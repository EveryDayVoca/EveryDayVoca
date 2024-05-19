//
//  VocaBookBaseView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class VocaBookBaseView: BaseView {

    // MARK: - Properties
    
    private let vocaBookSelectionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    private let vocaBookSelectionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    private let vocaBookSelectionImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.evText
    }
    
    let customView = UIView()
    
    
    // MARK: - Methods
    
    override func configureConstraints() {
        vocaBookSelectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        vocaBookSelectionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        vocaBookSelectionImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        customView.snp.makeConstraints {
            $0.top.equalTo(vocaBookSelectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureHierarchy() {
        [vocaBookSelectionView,
         customView].forEach { self.addSubview($0) }
        
        [vocaBookSelectionLabel,
         vocaBookSelectionImage].forEach { vocaBookSelectionView.addSubview($0) }
        
    }
    
}
