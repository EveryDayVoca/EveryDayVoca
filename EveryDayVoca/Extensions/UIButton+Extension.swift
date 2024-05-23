//
//  UIButton+Extension.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/22/24.
//

import UIKit

extension UIButton {
    func configureText(color: UIColor = .evText, font: UIFont, text: String = "") {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let attributedTitle = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
