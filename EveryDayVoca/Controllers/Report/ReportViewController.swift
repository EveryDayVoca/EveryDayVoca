//
//  ReportViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit
import DGCharts

final class ReportViewController: BaseViewController {
    
    // MARK: - property
    private let reportView = ReportView()
    private var selectedDate: DateComponents? = nil
    
    // 차트 데이터
    var monthDate = [VocaDate]()
    var difficulty = [Status: Int]()
    var studyData: (studiedWords: Int, totalWords: Int, dailyRates: [Date: Double]) = (0, 0, [:])
    var difficultySet: [String] = []
    var difficultCount: [Double] = []
    
    
    // MARK: - lifecycle
    override func loadView() {
        monthDate = VocaCoreDataManager.shared.getVocaMonthDates(forYear: 2024, month: 5)
        difficulty = VocaCoreDataManager.shared.calculateMonthlyStudyData(vocaDates: monthDate)
        studyData = VocaCoreDataManager.shared.calculateStudyData(vocaDates: monthDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.reportView
        
        configureStyle()
        configureDelegate()
        bind()
        setChart(data: difficultySet, values: difficultCount)
    }
    
    
    // MARK: - method
    override func configureStyle() {
        let titleLabel = UILabel().then {
            $0.text = "통계"
            $0.font = UIFont.pretendard(size: 17, weight: .semibold)
            $0.textColor = .evText
            $0.textAlignment = .center
        }
        navigationItem.titleView = titleLabel
    }
    
    override func configureDelegate() {
        self.reportView.calendar.delegate = self
        setCalendar()
    }
    
    override func bind() {
        self.difficultySet = ["어려워요", "애매해요", "외웠어요"]
        self.difficultCount = [Double(difficulty[.difficult]!),
                               Double(difficulty[.ambiguous]!),
                               Double(difficulty[.memorized]!)]
        
        //외웟어요 어려워요 애매해요 카운팅
        reportView.blue100Label.text = "\(difficulty[.memorized] ?? 0)개"
        reportView.blue50Label.text = "\(difficulty[.ambiguous] ?? 0)개"
        reportView.blue10Label.text = "\(difficulty[.difficult] ?? 0)개"
        
        // 출석률
        reportView.ratePercentLabel.text = "\(VocaCoreDataManager.shared.calculateAttendanceRate(year: 24, month: 5,    attendance: monthDate.count))%"
        
        //외운 단어 수
        reportView.countNumberLabel.text = "\(studyData.studiedWords)개"

    }
    
    private func setChart(data: [String], values: [Double]) {
        
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
        
        // 차트 가운데 입력값
        if studyData.studiedWords != 0 {
            let memorizeRate = Int(round(( Double(studyData.studiedWords) / Double(studyData.totalWords)) * 100 ))
            self.reportView.pieChart.centerText = "\(memorizeRate)%"
        } else {
            self.reportView.pieChart.centerText = "0%"
        }
        
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
    
    // 학습량 계산 후 달력에 업데이트
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        let date = dateComponents.date!
        //print(date)
        if self.studyData.dailyRates.keys.contains(date) {
            //print(self.studyData.dailyRates[date]!)
            switch self.studyData.dailyRates[date]! {
            case (1.0)...(10.0):
                return .image(UIImage(named: "Property_25"))
            case (21.0)...(40.0):
                return .image(UIImage(named: "Property_30"))
            case (41.0)...(60.0):
                return .image(UIImage(named: "Property_50"))
            case (61.0)...(80.0):
                return .image(UIImage(named: "Property_75"))
            case (81.0)...(100.0):
                return .image(UIImage(named: "Property_100"))
            default:
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        reportView.calendar.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
    
}
