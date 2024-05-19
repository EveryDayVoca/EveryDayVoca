//
//  FlashCardViewController.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/16/24.
//

import UIKit
import Shuffle

final class FlashCardViewController: BaseViewController {
    
    // MARK: - properties
    private var flashCardView: FlashCardView!
    
    // 임시 데이터
    private let wordData = [CardDataModel(word: "apple1", meaning: "사과1", options: .difficult),
                            CardDataModel(word: "apple2", meaning: "사과2", options: .difficult),
                            CardDataModel(word: "apple3", meaning: "사과3", options: .difficult),
                            CardDataModel(word: "apple4", meaning: "사과4", options: .difficult),
                            CardDataModel(word: "apple5", meaning: "사과5", options: .difficult),
                            CardDataModel(word: "apple6", meaning: "사과6", options: .difficult)]
    
    
    // MARK: - life cycles
    override func loadView() {
        flashCardView = FlashCardView()
        
        view = flashCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        configureNavigation()
        configureTarget()
    }
    
    override func configureDelegate() {
        flashCardView.cardStack.dataSource = self
        flashCardView.cardStack.delegate = self
    }
    
    private func configureNavigation() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        let titleLabel = UILabel(frame: titleView.bounds)
        titleLabel.text = "학습하기"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.pretendard(size: 17, weight: .semibold)
        titleView.addSubview(titleLabel)
        
        navigationItem.titleView = titleView
    }
    
    private func card(data: CardDataModel) -> SwipeCard {
        let card = CardView()
        card.configure(with: data)
        card.swipeDirections = [.left, .right]
        return card
    }
    
    private func configureTarget() {
        flashCardView.hardButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        flashCardView.normalButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        flashCardView.perfectButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    @objc func tappedButton(sender: UIButton) {
        // 데이터 업데이트
        
        // 다음 카드로 넘어가기
        flashCardView.cardStack.swipe(.right, animated: true)
    }
    
    func setCustomAlert() {
        let customAlertView = BasicCustomAlertViewController()
        
        customAlertView.titleText = "Notice"
        customAlertView.subtitleText = "목표 단어를 모두 확인하였습니다."
        customAlertView.buttonTitleText = "확인하기"
        
        customAlertView.modalPresentationStyle = .overFullScreen
        self.present(customAlertView, animated: false)
    }
}


// MARK: - extension

extension FlashCardViewController: SwipeCardStackDataSource {
    func cardStack(_ cardStack: Shuffle.SwipeCardStack, cardForIndexAt index: Int) -> Shuffle.SwipeCard {
        return card(data: wordData[index])
    }
    
    func numberOfCards(in cardStack: Shuffle.SwipeCardStack) -> Int {
        return wordData.count
    }
}

extension FlashCardViewController: SwipeCardStackDelegate {
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        // 모든 카드 소진시 얼럿창 호출 되며 이전 화면으로 되돌아가기
        setCustomAlert()
    }
}
