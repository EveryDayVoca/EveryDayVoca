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
    var date: Date?
    var dailyStudyData = [Status:Int]()
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = secondView
        setNavigationController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        bind(date: self.date)
        secondView.vocaListTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
    
    override func configureDelegate() {
        
        secondView.vocaListTableView.register(VocaListTableViewCell.self, forCellReuseIdentifier: VocaListTableViewCell.identifier)
        secondView.vocaListTableView.dataSource = self
        secondView.vocaListTableView.delegate = self
    }
    
    func bind(dateComponents: DateComponents?) {
        self.date = dateComponents?.date
    }
    
    // Date에 해당되는 Voca 데이터를 바인딩하는 함수
    private func bind(date: Date?) {
        guard let date = self.date else { return }
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let vocaDate = VocaCoreDataManager.shared.getVocaDateData(date: date)
        let statusBarWidth = UIScreen.main.bounds.width - 52
        
        if vocaDate.isEmpty {
            secondView
                .bindLevelAndDateLabel(level: "",
                                       date: "\(components.year ?? 0)년 \(components.month ?? 0)월 \(components.day ?? 0)일")
            secondView
                .reconfigureBarWidth(difficult: statusBarWidth, ambiguous: 0, memorized: 0)
            secondView
                .bindstatusPercentLabel(difficult: 0, ambiguous: 0, memorized: 0)
            
        } else {
            let leadWordIndex = Int(vocaDate[0].leadWordIndex)
            let totalWordCount = Int(vocaDate[0].totalWordCount)
            
            // vocas 구하기
            VocaBookData.shared.vocas = VocaCoreDataManager.shared.getVocaDataWithIndex(firstIndex: leadWordIndex, count: totalWordCount)
            
            // status별 개수 구하기
            self.dailyStudyData = VocaCoreDataManager.shared
                .getStudyData(index: leadWordIndex, count: totalWordCount)
            let difficult = dailyStudyData[.difficult] ?? 0
            let ambiguous = dailyStudyData[.ambiguous] ?? 0
            let memorized = dailyStudyData[.memorized] ?? 0
            
            
            let total = CGFloat(difficult + ambiguous + memorized)
            
            let difficultPercent = CGFloat(difficult) / total
            let ambiguousPercent = CGFloat(ambiguous) / total
            let memorizedPercent = CGFloat(memorized) / total
            
            let difficultBarWidth = statusBarWidth
            let ambiguousBarWidth = (ambiguousPercent + memorizedPercent) * statusBarWidth
            let memorizedBarWidth = memorizedPercent * statusBarWidth
            
            print("\(VocaBookData.shared.vocas[0].vocaDeck ?? "")단계")
            
            // levelLabel, dateLabel 바인딩
            secondView.bindLevelAndDateLabel(level: "\(VocaBookData.shared.vocas[0].vocaDeck ?? "")단계",
                                             date: "\(components.year ?? 0)년 \(components.month ?? 0)월 \(components.day ?? 0)일")
            
            // statusBar 바인딩
            secondView.reconfigureBarWidth(
                difficult: difficultBarWidth,
                ambiguous: ambiguousBarWidth,
                memorized: memorizedBarWidth
            )
            
            // statusPercentLabel 바인딩
            secondView.bindstatusPercentLabel(
                difficult: Int(difficultPercent * 100),
                ambiguous: Int(ambiguousPercent * 100),
                memorized: Int(memorizedPercent * 100)
            )
        }
    }
    
    
    private func configureAddTarget() {
        // yesterday 버튼
        secondView.yesterDayButton.addTarget(self, action: #selector(tappedYesterdayButton), for: .touchUpInside)
        
        // tomorrow 버튼
        secondView.tomorrowButton.addTarget(self, action: #selector(tappedTomorrowButton), for: .touchUpInside)
    }
    
    @objc func tappedYesterdayButton() {
        VocaBookData.shared.vocas = []
        let yesterdayDate = shiftDate(offset: -1, from: self.date)
        self.date = yesterdayDate
        self.bind(date: yesterdayDate)
        secondView.vocaListTableView.reloadData()
    }
    
    @objc func tappedTomorrowButton() {
        VocaBookData.shared.vocas = []
        let tomorrowDate = shiftDate(offset: 1, from: self.date)
        self.date = tomorrowDate
        self.bind(date: tomorrowDate)
        secondView.vocaListTableView.reloadData()
    }
    
    func shiftDate(offset: Int, from date: Date?) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = offset
        return Calendar.current.date(byAdding: dateComponents, to: date!)
    }
    
}


extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VocaBookData.shared.vocas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaListTableViewCell.identifier, for: indexPath) as? VocaListTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.bind(voca: VocaBookData.shared.vocas[indexPath.row])
        return cell
    }
    
}


extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVocaFlashCardVC = MyVocaFlashCardViewController()
        myVocaFlashCardVC.voca = VocaBookData.shared.vocas[indexPath.row]
        myVocaFlashCardVC.index = indexPath.row
        self.navigationController?.pushViewController(myVocaFlashCardVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
