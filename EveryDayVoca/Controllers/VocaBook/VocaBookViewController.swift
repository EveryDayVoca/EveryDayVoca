//
//  VocaBookViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit
import CoreData

final class VocaBookViewController: BaseViewController {
    
    // MARK: - Properties

    private let vocaBookVocaListView = VocaBookVocaListView()
    private let titleLabel = UILabel().then {
        $0.text = "나의 단어 사전"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .center
    }
    
    var vocas: [Voca] = [
        Voca(english: "apple", korean: "사과", pronunciation: "ˈæpl", status: .memorized, vocaBook: "초등"),
        Voca(english: "acid", korean: "산", pronunciation: "ˈæsɪd", status: .memorized, vocaBook: "중고등"),
        Voca(english: "absorb", korean: "흡수하다", pronunciation: "əb|sɔːrb", status: .ambiguous, vocaBook: "중고등"),
        Voca(english: "delicate", korean: "미묘한", pronunciation: "ˈdelɪkət", status: .difficult, vocaBook: "중고등")
    ]
    
    var vocaBook = "전체"
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = vocaBookVocaListView
        self.navigationItem.titleView = titleLabel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
    
    // MARK: - Methods
    override func configureStyle() {
        super.configureStyle()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        vocaBookVocaListView.vocaListTableView.register(VocaListTableViewCell.self, forCellReuseIdentifier: VocaListTableViewCell.identifier)
        vocaBookVocaListView.vocaListTableView.dataSource = self
        vocaBookVocaListView.vocaListTableView.delegate = self
    }
    
    override func bind() {
        super.bind()
        
        vocaBookVocaListView.bind(vocaBook: vocaBook)
    }
    
    private func configureAddTarget() {
        // 필터 버튼
        vocaBookVocaListView.tableFilterButton.addTarget(self, action: #selector(tappedTableFilterButton), for: .touchUpInside)
        
        // 보기 옵션 버튼
    }
    
    @objc func tappedTableFilterButton() {
        let filterPopoverVC = VocaBookFilterPopoverViewController()
        filterPopoverVC.modalPresentationStyle = .popover
        filterPopoverVC.preferredContentSize = CGSizeMake(filterPopoverVC.view.frame.width, filterPopoverVC.view.frame.height)
//        filterPopoverVC.preferredContentSize = CGSizeMake(100, 88)
        self.present(filterPopoverVC, animated: true)
    }
    
    
}

extension VocaBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaListTableViewCell.identifier, for: indexPath) as? VocaListTableViewCell else { return UITableViewCell() }
        
        cell.bind(voca: vocas[indexPath.row])
        
        return cell
    }
    
}

extension VocaBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100    // 그림자 포함 높이
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let myVocaFlashCardVC =
//    }
}
