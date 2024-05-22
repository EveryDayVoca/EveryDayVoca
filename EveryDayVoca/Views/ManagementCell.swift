//
//  ManagementCell.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/19/24.
//

import UIKit

final class ManagementCell: BaseCollectionViewCell {
    
    // MARK: - properties
    private let vocaShadowView = UIView().then {
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
    }
    
    private let vocaContainerView = UIView().then {
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    private let vocaBookLabel = UILabel().then {
        $0.textColor = .evText
        $0.textAlignment = .center
        $0.font = .pretendard(size: 24, weight: .semibold)
    }
    
    private let vocaCountLabel = UILabel().then {
        $0.textColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1)
        $0.textAlignment = .center
        $0.font = .pretendard(size: 18, weight: .regular)
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        vocaBookLabel.text = nil
        vocaCountLabel.text = nil
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(vocaShadowView)
        self.vocaShadowView.addSubview(vocaContainerView)
        self.vocaContainerView.addSubview(vocaBookLabel)
        self.vocaContainerView.addSubview(vocaCountLabel)
    }
    
    override func configureConstraints() {
        vocaShadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vocaContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vocaBookLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        
        vocaCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.vocaBookLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(49)
        }
    }
}
