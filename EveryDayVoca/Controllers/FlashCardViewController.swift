//
//  FlashCardViewController.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/16/24.
//

import UIKit

final class FlashCardViewController: BaseViewController {
    
    // MARK: - properties
    private let flashCardView = FlashCardView()
    private var isWordPage: Bool = true

    // MARK: - life cycles
    override func loadView() {
        view = self.flashCardView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureAddTarget()
    }
    
    private func configureAddTarget() {
        flashCardView.cardButton.addTarget(self, action: #selector(tappedcardButton), for: .touchUpInside)
    }
    
    @objc private func tappedcardButton() {
        isWordPage.toggle()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 24, weight: .semibold),
                                                         .foregroundColor: UIColor.evText,
                                                         .underlineStyle: 0]
        let text = isWordPage ? "Apple" : "사과"
        let attributedTitle = NSAttributedString(string: text, attributes: attributes)
        flashCardView.cardButton.setAttributedTitle(attributedTitle, for: .normal)
        UIButton.transition(with: flashCardView.cardButton,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: nil,
                          completion: nil)
    }
}
