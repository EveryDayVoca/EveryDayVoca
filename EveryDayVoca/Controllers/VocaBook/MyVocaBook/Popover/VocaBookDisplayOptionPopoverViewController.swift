//
//  VocaBookDisplayOptionPopoverViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/19/24.
//

import UIKit

enum DisplayOption {
    case englishOnly
    case koreanOnly
    case englishAndKorean
}

class VocaBookDisplayOptionPopoverViewController: BaseViewController {

    // MARK: - Properties
    
    private let vocaBookPopoverView = VocaBookPopoverView()
    let dataManager = VocaBookData.shared
    var displayOptions:[DisplayOption] = [.englishOnly, .koreanOnly, .englishAndKorean]
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = vocaBookPopoverView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methods
    
    override func configureStyle() {
        super.configureStyle()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        let tableView = vocaBookPopoverView.tableView
        tableView.register(VocaBookDisplayOptionPopoverTableViewCell.self, 
                           forCellReuseIdentifier: VocaBookDisplayOptionPopoverTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
    }
}

extension VocaBookDisplayOptionPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaBookDisplayOptionPopoverTableViewCell.identifier) as? VocaBookDisplayOptionPopoverTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.bind(displayOption: displayOptions[indexPath.row], selectedOption: dataManager.selectedDisplayOption)
        
        return cell
    }
    
    
}

extension VocaBookDisplayOptionPopoverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataManager.selectedDisplayOption = displayOptions[indexPath.row]
        tableView.reloadData()
    }
    
}
