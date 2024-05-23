//
//  SecondViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/22/24.
//

import UIKit

final class SecondViewController: BaseViewController {
    
    // MARK: - Properties
    
    let secondView = SecondView()
    var dailyStudyData = [Status:Int]()
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = secondView
        setNavigationController()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        print("viewWillDisappear")
    }
    
    
    
    // MARK: - Methods
    
    func setNavigationController() {
        let navigationBarTitleLabel = UILabel().then {
            $0.text = "일일 학습량"
            $0.font = UIFont.pretendard(size: 17, weight: .semibold)
            $0.textAlignment = .center
        }
        self.navigationItem.titleView = navigationBarTitleLabel
    }
    
    
    func bind(dateComponents: DateComponents?) {
        print("bind")
        
        guard let date = dateComponents?.date else { return }
        let vocaDate = VocaCoreDataManager.shared.getVocaDateData(date: date)
        
        guard vocaDate != [] else { return }
        let leadWordIndex = Int(vocaDate[0].leadWordIndex)
        let studiedWordCount = Int(vocaDate[0].studiedWordCount)
        
        self.dailyStudyData = VocaCoreDataManager.shared
            .getStudyData(index: leadWordIndex, count: studiedWordCount)
        
//        self.dailyStudyData = [.difficult:5, .ambiguous:7, .memorized:10, .none:5]
        let difficult = dailyStudyData[.difficult] ?? 0
        let ambiguous = dailyStudyData[.ambiguous] ?? 0
        let memorized = dailyStudyData[.memorized] ?? 0
        
        
        // levelLabel
        secondView.levelLabel.text = "1단계"
        
        // statusBar
        secondView.remakeConstraints(difficult: difficult, ambiguous: ambiguous, memorized: memorized)
    }
    
    
    
}
