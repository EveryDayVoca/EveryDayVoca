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
    let displayOptionPopoverVC = VocaBookDisplayOptionPopoverViewController()
    var index: Int = 0
    
    var vocas: [Voca] = []
    var vocaDecks: [VocaDeck] = []
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = vocaBookVocaListView
        setNavigationController()
        VocaBookData.shared.getVocaData()
        VocaBookData.shared.getVocaDeckData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
        
        displayOptionPopoverVC.selectedDisplayOption = { index in
            self.index = index
            self.vocaBookVocaListView.vocaListTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        vocaBookVocaListView.vocaListTableView.reloadData()
        VocaBookData.shared.dataUpdate = { [weak self] in
            guard let self = self else { return }
            vocas = VocaBookData.shared.vocas
            vocaBookVocaListView.vocaListTableView.reloadData()
            print("dataUpdate 클로저 실행됨")
        }
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
        vocas = VocaBookData.shared.vocas
        vocaDecks = VocaBookData.shared.vocaDecks
        vocaBookVocaListView.bind(vocaBook: VocaBookData.shared.currentVocaDeck)
    }
    
    private func configureAddTarget() {
        // 필터 버튼
        vocaBookVocaListView.tableFilterButton.addTarget(self, action: #selector(tappedTableFilterButton), for: .touchUpInside)
        
        // 보기 옵션 버튼
        vocaBookVocaListView.tableDisplayOptionButton.addTarget(self, action: #selector(tappedTableDisplayOptionButton), for: .touchUpInside)
        
        // VocaDeck 뷰 클릭
        vocaBookVocaListView.vocaBookSelectButton.addTarget(self, action: #selector(tappedVocaBookSelectButton), for: .touchUpInside)
    }
    
    @objc func tappedNavigationBarPlusButton() {
        let addVocaVC = VocaBookAddVocaViewController()
        addVocaVC.completion = { [weak self] in
            guard let self = self else { return }
            
            vocas = VocaBookData.shared.getVocaDatas(forVocaDeck: vocaBookVocaListView.currentVocaBookLabel.text ?? "ALL")
            vocaBookVocaListView.vocaListTableView.reloadData()
        }
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
    
    @objc func tappedVocaBookSelectButton() {
        print("vocaBookTitle 클릭")
        let managementVC = ManagementViewController()
        
        managementVC.completion = { [weak self] vocaDeckTitle in
            guard let self = self else { return }
            VocaBookData.shared.getVocaData(forVocaDeck: vocaDeckTitle)
            vocas = VocaBookData.shared.vocas
            vocaBookVocaListView.currentVocaBookLabel.text = vocaDeckTitle
            vocaBookVocaListView.vocaListTableView.reloadData()
        }
        
        self.navigationController?.pushViewController(managementVC, animated: true)
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
        
        switch index {
            
        case 0:
            cell.koreanLabel.isHidden = true
            cell.englishLabel.isHidden = false
            
        case 1:
            cell.koreanLabel.isHidden = false
            cell.englishLabel.isHidden = true
            
        case 2:
            cell.koreanLabel.isHidden = false
            cell.englishLabel.isHidden = false
            
        default:
            cell.koreanLabel.isHidden = false
            cell.englishLabel.isHidden = false
        }
        
        return cell
    }
    
}

extension VocaBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
