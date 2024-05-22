//
//  MyVocaFlashCardViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class MyVocaFlashCardViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let myVocaFlashCardView = MyVocaFlashCardView()
    
    var voca: Voca?
    var index: Int?
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = myVocaFlashCardView
        self.tabBarController?.tabBar.isHidden = true
        setNavigationController()
        configureAddTarget()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Methods
    
    override func configureStyle() { 
        super.configureStyle()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
    }
    
    override func bind() {
        super.bind()
        
        guard let voca = voca else { return }
        myVocaFlashCardView.bind(voca: voca)
    }
    
    func setNavigationController() {
        let navigationBarTitleLabel = UILabel().then {
            $0.text = "나의 단어 사전"
            $0.font = UIFont.pretendard(size: 17, weight: .semibold)
            $0.textAlignment = .center
        }
        
        let navigationBarPlusButton = UIBarButtonItem().then {
            $0.image = UIImage(named: "plus")
            $0.target = self
            $0.action = #selector(tappedNavigationBarPlusButton)
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.evText
        self.navigationItem.titleView = navigationBarTitleLabel
        self.navigationItem.rightBarButtonItem = navigationBarPlusButton
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @objc func tappedNavigationBarPlusButton() {
        let addVocaVC = VocaBookAddVocaViewController()
        present(addVocaVC, animated: true)
    }
    
    
    private func configureAddTarget() {
        // status 버튼
        myVocaFlashCardView.difficultButton.addTarget(self, action: #selector(tappedStatusButton), for: .touchUpInside)
        
        myVocaFlashCardView.ambiguousButton.addTarget(self, action: #selector(tappedStatusButton), for: .touchUpInside)
        
        myVocaFlashCardView.memorizedButton.addTarget(self, action: #selector(tappedStatusButton), for: .touchUpInside)
    }
    
    @objc func tappedStatusButton(_ button: UIButton) {
        guard let voca = voca,
            let index = index else { return }
        
        switch button.titleLabel?.text {
        case Status.difficult.rawValue:
            VocaBookData.shared.updateVocaStatus(voca, status: Status.difficult.rawValue, index: index)
            
        case Status.ambiguous.rawValue:
            VocaBookData.shared.updateVocaStatus(voca, status: Status.ambiguous.rawValue, index: index)
            
        case Status.memorized.rawValue:
            VocaBookData.shared.updateVocaStatus(voca, status: Status.memorized.rawValue, index: index)
            
        case Status.none.rawValue:
            VocaBookData.shared.updateVocaStatus(voca, status: Status.none.rawValue, index: index)
            
        default:
            VocaBookData.shared.updateVocaStatus(voca, status: Status.none.rawValue, index: index)
        }
        myVocaFlashCardView.updateButtonConfiguration()
        print(">>>>> \(voca)")
    }
    
    
}
