//
//  File.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/20/24.
//

import Foundation
import UIKit

class FlashAlertView: BaseView {
    
    // MARK: - properties
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.evBackground
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.layer.masksToBounds = false
        $0.layer.borderColor = UIColor.gray50.cgColor
        $0.layer.borderWidth = 1
    }
    
    var title = UILabel().then {
        $0.font = UIFont.pretendard(size: 20, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    var subtitle = UILabel().then {
        $0.font = UIFont.pretendard(size: 17, weight: .regular)
        $0.textColor = UIColor.evText
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    var button = UIButton().then {
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.gray50
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .semibold),
                                                         .foregroundColor: UIColor.evBackground,
                                                         .underlineStyle: 0]
        let attributedTitle = NSAttributedString(string: "확인하기", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    
    // MARK: - methods
    
    override func configureHierarchy() {
        self.addSubview(backgroundView)
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(button)
    }
    
    override func configureConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        subtitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(title.snp.bottom).offset(16)
        }
        
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(subtitle.snp.bottom).offset(16)
            $0.height.equalTo(45)
            $0.bottom.equalTo(backgroundView.snp.bottom).inset(16)
        }
    }
}
