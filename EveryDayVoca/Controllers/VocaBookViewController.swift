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
    
    var vocas: [Voca] = []
    
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
        vocaBookVocaListView.vocaListTableView.dataSource = self
    }
    
    override func bind() {
        super.bind()
    }
    
    private func configureAddTarget() {
        // 필터 버튼
        vocaBookVocaListView.tableFilterButton.addTarget(self, action: #selector(tappedTableFilterButton), for: .touchUpInside)
        
        // 보기 옵션 버튼
    }
    
    @objc func tappedTableFilterButton() {
        let filterPopoverVC = VocaBookFilterPopoverViewController()
        filterPopoverVC.modalPresentationStyle = .popover
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
