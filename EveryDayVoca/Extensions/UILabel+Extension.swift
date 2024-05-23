//
//  UILabel+Extension.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/22/24.
//

import UIKit

extension UILabel {
    func configureText(alignment: NSTextAlignment = .left, color: UIColor = .evText, font: UIFont, text: String? = nil, numberOfLines: Int = 1) {
        self.textAlignment = alignment
        self.textColor = color
        self.font = font
        self.text = text
        self.numberOfLines = numberOfLines
    }
}
