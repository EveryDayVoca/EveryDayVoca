//
//  BaseCollectionViewCell.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/19/24.
//

import UIKit
import SnapKit
import Then

class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureUI() {
        self.backgroundColor = .evBackground
    }
    
    func configureHierarchy() { }
    
    func configureConstraints() { }
}
