//
//  VocaBookAddVocaView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class VocaBookAddVocaView: BaseView {
    
    // MARK: - Properties
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
    }
    
    let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 17, weight: .regular),
                                                             .foregroundColor: UIColor.gray50,
                                                             .underlineStyle: 0]
    
    lazy var englishTextField = UITextField().then {
        $0.backgroundColor = UIColor.evBackground
        $0.textColor = UIColor.evText
        $0.attributedPlaceholder = NSAttributedString(string: "영단어 입력하기.", attributes: attributes)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .yes
    }
    
    lazy var koreanTextField = UITextField().then {
        $0.backgroundColor = UIColor.evBackground
        $0.textColor = UIColor.evText
        $0.attributedPlaceholder = NSAttributedString(string: "뜻 입력하기.", attributes: attributes)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .yes
    }
    
    
    // MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
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
