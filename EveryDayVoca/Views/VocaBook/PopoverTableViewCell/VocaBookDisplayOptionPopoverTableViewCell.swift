//
//  VocaBookDisplayOptionPopoverTableViewCell.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/19/24.
//

import UIKit

class VocaBookDisplayOptionPopoverTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = String(describing: VocaBookDisplayOptionPopoverTableViewCell.self)
    
    var indexPath: IndexPath?
    
    let label = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.evText
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    let selectionImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.blue100
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
        
        selectionImage.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(label.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(label)
            $0.size.equalTo(20)
        }
    }
    
    private func configureHierarchy() {
        [label,
         selectionImage].forEach { contentView.addSubview($0) }
    }
    
    func bind(displayOption: DisplayOption, selectedOption: DisplayOption) {
        
        let isSelected = displayOption == selectedOption
        
        switch displayOption {
            
        case .englishOnly:
            label.text = "단어(영)"
            
        case .koreanOnly:
            label.text = "의미(한)"
            
        case .englishAndKorean:
            label.text = "단어 + 의미"
        }
        
        
        switch isSelected {
        case true:
            selectionImage.image = UIImage(systemName: "circle.inset.filled")
            
        case false:
            selectionImage.image = UIImage(systemName: "circle")
        }
    }
    
}
