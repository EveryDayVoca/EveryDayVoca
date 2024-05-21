//
//  StudyViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

class StudyViewController: UIViewController {
    
    // 임시 버튼 ( 삭제해도 됨 )
    private var practiceButton: UIButton = {
        var button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.blue100
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 20, weight: .semibold),
                                                         .foregroundColor: UIColor.evBackground]
        let attributedTitle = NSAttributedString(string: "학습하기", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 임시 버튼 설정 ( 삭제해도 됨 )
        view.backgroundColor = .white
        view.addSubview(practiceButton)
        configureConstraints()
        
        // 다음 VC으로 넘기는 동작 수행 ( 삭제 X )
        practiceButton.addTarget(self, action: #selector(tappedPracticeButton), for: .touchUpInside)
    }
    
    // 임시 버튼 constraints ( 삭제해도 됨 )
    func configureConstraints() {
        practiceButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
    }
    
    // 다음 VC으로 넘기기 ( 삭제 X )
    @objc func tappedPracticeButton() {
        let nextVC = FlashCardViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}
