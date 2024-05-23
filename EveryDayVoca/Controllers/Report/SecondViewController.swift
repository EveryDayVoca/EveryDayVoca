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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .evBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    // MARK: - Methods
    func bind(dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        let vocaDate = VocaCoreDataManager.shared.getVocaDateData(date: date)
        
        guard vocaDate != [] else { return }
        let leadWordIndex = Int(vocaDate[0].leadWordIndex)
        let studiedWordCount = Int(vocaDate[0].studiedWordCount)
        
        self.dailyStudyData = VocaCoreDataManager.shared
            .getStudyData(index: leadWordIndex, count: studiedWordCount)
        
        let difficult = dailyStudyData[.difficult] ?? 0
        let ambiguous = dailyStudyData[.ambiguous] ?? 0
        let memorized = dailyStudyData[.memorized] ?? 0
        
        secondView.reConfigureStatusBar(difficult: difficult, ambiguous: ambiguous, memorized: memorized)
    }
    
    
}
