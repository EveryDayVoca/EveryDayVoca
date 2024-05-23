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
    
    // MARK: - life cycles
    override func loadView() {
        view = studyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 다음 VC으로 넘기는 동작 수행 ( 삭제 X )
        studyView.vocaStudyButton.addTarget(self, action: #selector(tappedPracticeButton), for: .touchUpInside)
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func bind() {
        // To Do -> 데이터 반영
        configureChart(values: [10, 20, 30].map{ Double($0) })
    }
    
    private func configureNavigation() {
        navigationItem.titleView = studyView.titleLabel
    }
    
    private func configureChart(values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = PieChartDataEntry(value: values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        pieChartDataSet.sliceSpace = 1
        pieChartDataSet.valueTextColor = .clear
        pieChartDataSet.colors = [.blue100, .blue50, .blue10]
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        // To Do -> 뷰에 바인딩 PieChartData(dataSet: pieChartDataSet)
    }
    @objc func tappedPracticeButton() {
        let nextVC = FlashCardViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}
