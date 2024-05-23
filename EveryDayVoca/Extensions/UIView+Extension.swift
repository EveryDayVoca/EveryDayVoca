//
//  UIView+Extension.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/22/24.
//

import UIKit

extension UIView {
    func configureView(color: UIColor? = nil, clipsToBounds: Bool = false, cornerRadius: CGFloat) {
        self.backgroundColor = color
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
    }
    
    func configureShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 12
    }
}
