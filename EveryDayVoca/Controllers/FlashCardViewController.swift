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
    
    override func configureDelegate() {
        flashCardView.cardStack.dataSource = self
    }
    
    func card(data: CardDataModel) -> SwipeCard {
        let card = CardView()
        card.configure(with: data)
        card.swipeDirections = [.left, .right]
        return card
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
