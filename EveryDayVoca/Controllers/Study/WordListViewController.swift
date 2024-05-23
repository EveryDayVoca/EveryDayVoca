//
//  WordListViewController.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/23/24.
//

import UIKit

final class WordListViewController: BaseViewController {

    // MARK: - properties
    private var wordListView: VocaBookVocaListView!
    private var coreDataManager = VocaCoreDataManager.shared
    private var wordData = [Voca]()
    
    
    // MARK: - lifecycles
    override func loadView() {
        wordListView = VocaBookVocaListView()
        view = wordListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        VocaBookData.shared.dataUpdate = { [weak self] in
            guard let self = self else { return }
            wordData = VocaBookData.shared.vocas
            wordListView.vocaListTableView.reloadData()
            print("dataUpdate 클로저 실행됨")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - methods
    override func configureStyle() {
        configureDelegate()
        configureNavigation()
        configureUI()
        configureAddTarget()
    }
    
    override func configureDelegate() {
        let tableView = wordListView.vocaListTableView
        tableView.register(VocaListTableViewCell.self, forCellReuseIdentifier: VocaListTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureNavigation() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        let titleLabel = UILabel(frame: titleView.bounds)
        titleLabel.text = "단어 리스트"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.pretendard(size: 17, weight: .semibold)
        
        titleView.addSubview(titleLabel)
        navigationItem.titleView = titleView
    }
    
    private func configureUI() {
        wordListView.vocaBookChevronImage.isHidden = true
    }
    
    override func bind() {
        super.bind()
        VocaBookData.shared.vocas = coreDataManager.getVocaDataWithIndex(firstIndex: 1, count: 10)
        wordData = coreDataManager.getVocaDataWithIndex(firstIndex: 1, count: 10)
    }
    
    private func configureAddTarget() {
        wordListView.tableFilterButton.addTarget(self, action: #selector(tappedTableFilterButton), for: .touchUpInside)
        wordListView.tableDisplayOptionButton.addTarget(self, action: #selector(tappedTableDisplayOptionButton), for: .touchUpInside)
    }
    
    @objc func tappedTableFilterButton() {
        let filterPopoverVC = VocaBookFilterPopoverViewController()
        filterPopoverVC.modalPresentationStyle = .popover
        filterPopoverVC.preferredContentSize = .init(width: 150, height: 126)
        filterPopoverVC.popoverPresentationController?.sourceView = wordListView.tableFilterButton
        filterPopoverVC.popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(
                x: wordListView.tableFilterButton.bounds.midX,
                y: wordListView.tableFilterButton.bounds.midY
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
        displayOptionPopoverVC.popoverPresentationController?.sourceView = wordListView.tableDisplayOptionButton
        displayOptionPopoverVC.popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(
                x: wordListView.tableDisplayOptionButton.bounds.midX,
                y: wordListView.tableDisplayOptionButton.bounds.midY
            ),
            size: .zero
        )
        displayOptionPopoverVC.popoverPresentationController?.permittedArrowDirections = .up
        displayOptionPopoverVC.popoverPresentationController?.delegate = self
        present(displayOptionPopoverVC, animated: true)
    }
}


// MARK: - extension

extension WordListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaListTableViewCell.identifier, for: indexPath) as? VocaListTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(voca: wordData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

}


extension WordListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}


extension WordListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
}
