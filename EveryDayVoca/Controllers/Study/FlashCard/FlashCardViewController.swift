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
    private var customAlertVC: FlashAlertViewController!
    private var currentIndex = 0
    private let coreDataManager = VocaCoreDataManager.shared
    private var wordData = [Voca]()
    private let tts = TTS()
    
    var toStudyVC: (([Voca]) -> Void)?
    var completion: (() -> Void)?
    
    // MARK: - life cycles
    override func loadView() {
        flashCardView = FlashCardView()
        customAlertVC = FlashAlertViewController()
        
        wordData = coreDataManager.getVocaDataWithIndex(firstIndex: 1, count: 10)
        
        if coreDataManager.getVocaDateData(date: Date()) == []{
            coreDataManager.createVocaDateData(index: 1, count: 10)
            // userDefaults에도 값 업데이트 해야 함.
        }
        
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
        configureButtonStyle()
        configureTarget()
        configureProgressBar()
    }
    
    override func configureDelegate() {
        flashCardView.cardStack.dataSource = self
        flashCardView.cardStack.delegate = self
        customAlertVC.delegate = self
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
    
    private func configureButtonStyle() {
        let currentStatus = wordData[currentIndex].status ?? Status.none.rawValue
        flashCardView.setButtonStyle(selectedStatus: currentStatus)
    }
    
    private func card(data: Voca) -> SwipeCard {
        let card = CardView()
        card.configure(with: data)
        card.swipeDirections = [.left, .right]
        return card
    }
    
    private func configureTarget() {
        flashCardView.previousCardButton.addTarget(self, action: #selector(tappedPreviousButton), for: .touchUpInside)
        flashCardView.speakButton.addTarget(self, action: #selector(tappedSpeakButton), for: .touchUpInside)
        flashCardView.difficultButton.addTarget(self, action: #selector(tappedStatusButton), for: .touchUpInside)
        flashCardView.ambiguousButton.addTarget(self, action: #selector(tappedStatusButton), for: .touchUpInside)
        flashCardView.memorizedButton.addTarget(self, action: #selector(tappedStatusButton), for: .touchUpInside)
    }
    
    @objc func tappedPreviousButton() {
        flashCardView.cardStack.undoLastSwipe(animated: true)
        currentIndex = max(currentIndex-1, 0)
        configureProgressBar()
        configureButtonStyle()
    }
    
    
    @objc func tappedStatusButton(sender: UIButton) {
        
        flashCardView.updateButtonStyle(button: sender)
        
        guard let buttonStatus = sender.titleLabel?.text else { return }
        let todayData = coreDataManager.getVocaDateData(date: Date())
        
        switch buttonStatus {
        case "어려워요":
            if wordData[currentIndex].status == Status.memorized.rawValue {
                coreDataManager.updateVocaDateStudiedWordCount( todayData[0], isPlus: false)
            }
            coreDataManager.updateVocaStatus(wordData[currentIndex], status: .difficult)
            wordData[currentIndex].status = Status.difficult.rawValue
        case "애매해요":
            if wordData[currentIndex].status == Status.memorized.rawValue {
                coreDataManager.updateVocaDateStudiedWordCount( todayData[0], isPlus: false)
            }
            coreDataManager.updateVocaStatus(wordData[currentIndex], status: .ambiguous)
            wordData[currentIndex].status = Status.ambiguous.rawValue
        case "외웠어요":
            if wordData[currentIndex].status != Status.memorized.rawValue {
                coreDataManager.updateVocaDateStudiedWordCount( todayData[0], isPlus: true)
            }
            coreDataManager.updateVocaStatus(wordData[currentIndex], status: .memorized)
            wordData[currentIndex].status = Status.memorized.rawValue
        default:
            wordData[currentIndex].status = Status.none.rawValue
        }
        
        configureButtonStyle()
        
        self.flashCardView.cardStack.swipe(.right, animated: true)
    }
    
    @objc func tappedSpeakButton(sender: UIButton) {
        guard let english = self.wordData[currentIndex].english else { return }
        self.tts.play(str: english, language: .english)
    }
    
    func configureProgressBar() {
        let percentage = Double(currentIndex) / Double(wordData.count)
        flashCardView.progressBar.progress = Float(percentage)
        flashCardView.percentLabel.text = "\(round(percentage*100))%"
    }
    
    func configureCustomAlert() {
        customAlertVC.titleText = "Notice"
        customAlertVC.subtitleText = "목표 단어를 모두 확인하였습니다."
        customAlertVC.buttonTitleText = "확인하기"
        
        customAlertVC.modalPresentationStyle = .overFullScreen
        self.present(customAlertVC, animated: false)
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
        flashCardView.progressBar.progress = 1.0
        flashCardView.percentLabel.text = "100%"
        configureCustomAlert()
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        currentIndex = min(currentIndex+1, wordData.count-1)
        configureProgressBar()
        configureButtonStyle()
    }
}

extension FlashCardViewController: CustomAlertDelegate {
    func confirm() {
        toStudyVC?(wordData)
        self.navigationController?.popViewController(animated: true)
    }
}
