//
//  VocaBookAddVocaView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class VocaBookAddVocaView: BaseView {
    
    // MARK: - Properties
    
    
    
    // MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.backgroundColor = .evBackground
    }
    
    override func configureHierarchy() { }
    
    override func configureConstraints() { }

}
