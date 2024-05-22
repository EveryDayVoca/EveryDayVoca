//
//  VocaBookBaseView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class VocaBookBaseView: BaseView {

    // MARK: - Properties
    
    let vocaBookSelectActionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    let currentVocaBookLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 14, weight: .medium)
    }
    
    private let vocaBookChevronImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.evText
    }
    
    let vocaBookSelectButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let customView = UIView()
    
    
    // MARK: - Methods
    
    override func configureHierarchy() {
        [vocaBookSelectActionView,
         customView,
        vocaBookSelectButton].forEach { self.addSubview($0) }
        
        [currentVocaBookLabel,
         vocaBookChevronImage].forEach { vocaBookSelectActionView.addSubview($0) }
        
    }
    
    override func configureConstraints() {
        vocaBookSelectActionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        currentVocaBookLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        vocaBookChevronImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(14)
        }
        
        vocaBookSelectButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        customView.snp.makeConstraints {
            $0.top.equalTo(vocaBookSelectActionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
