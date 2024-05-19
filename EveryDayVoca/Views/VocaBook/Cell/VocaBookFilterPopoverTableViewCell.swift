//
//  VocaBookPopoverTableViewCell.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/19/24.
//

import UIKit

final class VocaBookFilterPopoverTableViewCell: UITableViewCell {
    
    
    // MARK: - Properties
    static let identifier = String(describing: VocaBookFilterPopoverTableViewCell.self)
    
    var checkStatus: Bool = false
    
    let label = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.evText
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    let checkMarkImage = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.gray100
    }
    
    
    // MARK: - Methods
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        configureUI()
        configureConstraints()
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.evBackground
    }
    
    private func configureConstraints() {
        label.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview().inset(12)
        }
        
        checkMarkImage.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(label.snp.trailing).offset(12)
            $0.verticalEdges.equalTo(label)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    private func configureHierarchy() {
        [label,
        checkMarkImage].forEach { contentView.addSubview($0) }
    }
    
    func bind(status: Status) {
        switch status {
        case .difficult:
            label.text = "어려워요"
            
        case .ambiguous:
            label.text = "애매해요"
            
        case .memorized:
            label.text = "외웠어요"
        }
    }
    
    func changeCheckStatus() {
        self.checkStatus = !checkStatus
    }
}
