//
//  VocaBookPopoverViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/19/24.
//

import UIKit

struct Filter {
    let status: Status
    var isSelected: Bool
}

class VocaBookFilterPopoverViewController: BaseViewController {

    // MARK: - Properties
    
    private let vocaBookPopoverView = VocaBookPopoverView()
    let dataManager = VocaBookData.shared
    
    
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
        tableView.register(VocaBookFilterPopoverTableViewCell.self, 
                           forCellReuseIdentifier: VocaBookFilterPopoverTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
    }
}

extension VocaBookFilterPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filters.count
        return dataManager.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaBookFilterPopoverTableViewCell.identifier) as? VocaBookFilterPopoverTableViewCell 
        else {
            return UITableViewCell()
        }
        
        cell.bind(filter: dataManager.filters[indexPath.row])
        return cell
    }
    
    
}

extension VocaBookFilterPopoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataManager.filters[indexPath.row].isSelected = !dataManager.filters[indexPath.row].isSelected
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
