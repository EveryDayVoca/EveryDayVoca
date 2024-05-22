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
    
    var vocas: [Voca] = []
    var vocaBook = "전체"
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = vocaBookVocaListView
        setNavigationController()
        VocaBookData.shared.getVocaData()
        vocas = VocaBookData.shared.vocas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Methods
    
    func setNavigationController() {
        let navigationBarTitleLabel = UILabel().then {
            $0.text = "나의 단어 사전"
            $0.font = UIFont.pretendard(size: 17, weight: .semibold)
            $0.textAlignment = .center
        }
        
        let navigationBarPlusButton = UIBarButtonItem().then {
            $0.image = UIImage(named: "plus")
            $0.target = self
            $0.action = #selector(tappedNavigationBarPlusButton)
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.evText
        self.navigationItem.titleView = navigationBarTitleLabel
        self.navigationItem.rightBarButtonItem = navigationBarPlusButton
    }
    
    override func configureStyle() {
        super.configureStyle()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        let tableView = vocaBookVocaListView.vocaListTableView
        tableView.register(VocaListTableViewCell.self, forCellReuseIdentifier: VocaListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func bind() {
        super.bind()
        
        vocaBookVocaListView.bind(vocaBook: vocaBook)
    }
    
    private func configureAddTarget() {
        // 필터 버튼
        vocaBookVocaListView.tableFilterButton.addTarget(self, action: #selector(tappedTableFilterButton), for: .touchUpInside)
        
        // 보기 옵션 버튼
        vocaBookVocaListView.tableDisplayOptionButton.addTarget(self, action: #selector(tappedTableDisplayOptionButton), for: .touchUpInside)
    }
    
    @objc func tappedNavigationBarPlusButton() {
        let addVocaVC = VocaBookAddVocaViewController()
        present(addVocaVC, animated: true)
    }
    
    @objc func tappedTableFilterButton() {
        let filterPopoverVC = VocaBookFilterPopoverViewController()
        filterPopoverVC.modalPresentationStyle = .popover
        filterPopoverVC.preferredContentSize = .init(width: 150, height: 126)
        filterPopoverVC.popoverPresentationController?.sourceView = vocaBookVocaListView.tableFilterButton
        filterPopoverVC.popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(
                x: vocaBookVocaListView.tableFilterButton.bounds.midX,
                y: vocaBookVocaListView.tableFilterButton.bounds.midY
            ),
            size: .zero
        )
        filterPopoverVC.popoverPresentationController?.permittedArrowDirections = .up
        filterPopoverVC.popoverPresentationController?.delegate = self
        present(filterPopoverVC, animated: true)
    }
    
    @objc func tappedTableDisplayOptionButton() {
        let displayOptionPopoverVC = VocaBookDisplayOptionPopoverViewController()
        displayOptionPopoverVC.modalPresentationStyle = .popover
        displayOptionPopoverVC.preferredContentSize = .init(width: 150, height: 96)
        displayOptionPopoverVC.popoverPresentationController?.sourceView = vocaBookVocaListView.tableDisplayOptionButton
        displayOptionPopoverVC.popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(
                x: vocaBookVocaListView.tableDisplayOptionButton.bounds.midX,
                y: vocaBookVocaListView.tableDisplayOptionButton.bounds.midY
            ),
            size: .zero
        )
        displayOptionPopoverVC.popoverPresentationController?.permittedArrowDirections = .up
        displayOptionPopoverVC.popoverPresentationController?.delegate = self
        present(displayOptionPopoverVC, animated: true)
    }
}


extension VocaBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaListTableViewCell.identifier, for: indexPath) as? VocaListTableViewCell else { return UITableViewCell() }
        
        cell.bind(voca: vocas[indexPath.row])
        cell.selectionStyle = .none
        print("tableView cell: \(vocas[indexPath.row])")
        return cell
    }
    
}

extension VocaBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100    // 그림자 포함 높이
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVocaFlashCardVC = MyVocaFlashCardViewController()
        myVocaFlashCardVC.voca = vocas[indexPath.row]
        myVocaFlashCardVC.index = indexPath.row
        self.navigationController?.pushViewController(myVocaFlashCardVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension VocaBookViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
}
