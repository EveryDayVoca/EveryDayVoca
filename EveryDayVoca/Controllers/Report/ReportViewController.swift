//
//  ReportViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/22/24.
//

import UIKit
import DGCharts

final class ReportViewController: BaseViewController {
    
    let reportView = ReportView()
    
    let titleLabel = UILabel().then {
        $0.text = "통계"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = .evText
        $0.textAlignment = .center
    }
    
    var selectedDate: DateComponents? = nil
    
    // 차트 임시 데이터
    var difficulty: [String] = ["어려워요", "애매해요", "외웠어요"]
    var counts: [Double] = [20, 8, 12]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.reportView
        self.navigationItem.titleView = titleLabel
        
        configureDelegate()
        setChart(data: difficulty, values: counts)
        
    }
    
    override func configureDelegate() {
        self.reportView.calendar.delegate = self
        setCalendar()
    }
    
    // MARK: - piechart method
    func setChart(data: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<data.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: data[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        self.reportView.pieChart.data = pieChartData
        
        let colorSet: [UIColor] = [.blue100, .blue50, .blue10]
        pieChartDataSet.colors = colorSet
        
        self.reportView.pieChart.legend.enabled = false
        self.reportView.pieChart.chartDescription.enabled = false
        self.reportView.pieChart.isUserInteractionEnabled = false
        self.reportView.pieChart.holeRadiusPercent = 0.618
        // 차트 가운데 입력값 - 임시
        self.reportView.pieChart.centerText = "50%"
        
        
        pieChartDataSet.drawValuesEnabled = false
    }
}

// MARK: - extension
extension ReportViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func setCalendar() {
        self.reportView.calendar.delegate = self
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        self.reportView.calendar.selectionBehavior = dateSelection
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        // secondVC 값 바꿔야함
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
