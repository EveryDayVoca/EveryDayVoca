//
//  StudyViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit
import DGCharts

final class StudyViewController: BaseViewController {
    
    // MARK: - properties
    private let studyView = StudyView()
    
    private let coreDataManager = VocaCoreDataManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    // MARK: - life cycles
    override func loadView() {
        view = studyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func bind() {
        let user = userDefaultsManager.fetchUser()
        let startIndex = userDefaultsManager.fetchStartIndex()
        
        let status = coreDataManager.getStudyData(index: startIndex, count: user.amount)
        
        let memorized = status[.memorized] ?? 0
        let ambiguous = status[.ambiguous] ?? 0
        let difficult = status[.difficult] ?? 0
        let none = status[.none] ?? user.amount
        
        let allStatus = [memorized, ambiguous, difficult, none]
        
        print(allStatus)
        
        configureChart(values: allStatus.map{ Double($0) }, allStatus: allStatus, user: user)
    }
    
    private func configureNavigation() {
        navigationItem.titleView = studyView.titleLabel
    }
    
    private func configureChart(values: [Double], allStatus: [Int], user: User) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = PieChartDataEntry(value: values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        pieChartDataSet.sliceSpace = 1
        pieChartDataSet.valueTextColor = .clear
        pieChartDataSet.colors = [.blue100, .blue50, .blue10, .gray50]
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        studyView.bind(pieChartData: pieChartData, allStatus: allStatus, user: user)
    }
    
    private func configureAddTarget() {
        studyView.vocaStudyButton.addTarget(self, action: #selector(tappedVocaStudyButton), for: .touchUpInside)
        studyView.vocaListButton.addTarget(self, action: #selector(tappedVocaListButton), for: .touchUpInside)
    }
    
    @objc private func tappedVocaStudyButton() {
        let flashCardVC = FlashCardViewController()
        flashCardVC.completion = { self.bind() }
        
        navigationController?.pushViewController(flashCardVC, animated: true)
    }
    
    @objc private func tappedVocaListButton() {
        let wordListVC = WordListViewController()
        navigationController?.pushViewController(wordListVC, animated: true)
    }
}
