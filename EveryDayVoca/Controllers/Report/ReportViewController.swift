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
    var studyData: (studiedWords: Int, totalWords: Int, dailyRates: [String: Double]) = (0, 0, [:])
    var difficultySet: [String] = []
    var difficultCount: [Double] = []
    let yearFormat = DateFormatter().then {
        $0.dateFormat = "yyyy"
    }
    let monthFormat = DateFormatter().then {
        $0.dateFormat = "MM"
    }
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.reportView
        
        configureStyle()
        configureDelegate()
        bind()
        setChart(data: difficultySet, values: difficultCount)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
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
        let year = Int(yearFormat.string(from: Date()))!
        let month = Int(monthFormat.string(from: Date()))!
        monthDate = VocaCoreDataManager.shared.getVocaMonthDates(forYear: year, month: month)
        difficulty = VocaCoreDataManager.shared.calculateMonthlyStudyData(vocaDates: monthDate)
        studyData = VocaCoreDataManager.shared.calculateStudyData(vocaDates: monthDate)
        
        self.difficultySet = ["어려워요", "애매해요", "외웠어요"]
        self.difficultCount = [Double(difficulty[.memorized]!),
                               Double(difficulty[.ambiguous]!),
                               Double(difficulty[.difficult]!)]
        
        reportView.blue100Label.text = "\(difficulty[.memorized] ?? 0)개"
        reportView.blue50Label.text = "\(difficulty[.ambiguous] ?? 0)개"
        reportView.blue10Label.text = "\(difficulty[.difficult] ?? 0)개"
        
        reportView.ratePercentLabel.text = "\(VocaCoreDataManager.shared.calculateAttendanceRate(year: Int(yearFormat.string(from: Date()))!, month: Int(monthFormat.string(from: Date()))!,    attendance: monthDate.count))%"
        
        reportView.countNumberLabel.text = "\(studyData.studiedWords)개"
    }
    
    func reloadData() {
        monthDate = VocaCoreDataManager.shared.getVocaMonthDates(forYear: Int(yearFormat.string(from: Date()))!, month: Int(monthFormat.string(from: Date()))!)
        difficulty = VocaCoreDataManager.shared.calculateMonthlyStudyData(vocaDates: monthDate)
        studyData = VocaCoreDataManager.shared.calculateStudyData(vocaDates: monthDate)
        bind()
        setChart(data: difficultySet, values: difficultCount)
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
        
        let reportDailyVC = ReportDailyViewController()
        reportDailyVC.bind(dateComponents: dateComponents)
        navigationController?.pushViewController(reportDailyVC, animated: true)
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = VocaCoreDataManager.shared.dateComponentsToString(dateComponents) else {return nil}
        guard let rates = studyData.dailyRates[date] else {return nil}
        
        switch round(rates * 100.0) {
        case (1.0)...(20.0):
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
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        reportView.calendar.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}
