//
//  ManagementCell.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/19/24.
//

import UIKit

final class ManagementCell: BaseCollectionViewCell {
    
    // MARK: - properties
    private let containerView = UIView().then {
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
    }
    
    private let vocaBookLabel = UILabel().then {
        $0.font = .pretendard(size: 24, weight: .semibold)
        $0.textColor = .evText
        $0.textAlignment = .center
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
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
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(vocaBookLabel)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vocaBookLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
