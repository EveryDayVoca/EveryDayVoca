//
//  UIFont+Extension.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

extension UIFont {
    static func pretendard(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"
        var weightString: String
        
        switch weight {
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Medium"
        }
        
        guard let font = UIFont(name: "\(familyName)-\(weightString)", size: fontSize) else {
            print("프리텐다드체 폰트 변환 실패")
            return .systemFont(ofSize: fontSize, weight: weight)
        }
        
        return font
    }
}
