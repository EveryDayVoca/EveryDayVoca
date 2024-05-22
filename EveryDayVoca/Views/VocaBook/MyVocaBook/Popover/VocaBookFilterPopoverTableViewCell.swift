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
    
    var indexPath: IndexPath?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.evBackground
    }
    
    private func configureConstraints() {
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
        
        checkMarkImage.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(label.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(label)
            $0.size.equalTo(16)
        }
    }
    
    private func configureHierarchy() {
        [label,
        checkMarkImage].forEach { contentView.addSubview($0) }
    }
    
    func bind(filter: Filter) {
        switch filter.status {
        case .difficult:
            label.text = "어려워요"
            
        case .ambiguous:
            label.text = "애매해요"
            
        case .memorized:
            label.text = "외웠어요"
            
        case .none:
            label.text = "미학습"
        }
        
        switch filter.isSelected {
        case true:
            checkMarkImage.isHidden = false
            
        case false:
            checkMarkImage.isHidden = true
        }
    }
    
}
