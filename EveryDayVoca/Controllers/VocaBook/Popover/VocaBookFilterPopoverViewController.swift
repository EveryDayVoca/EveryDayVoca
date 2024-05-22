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
        return VocaBookData.shared.filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaBookFilterPopoverTableViewCell.identifier) as? VocaBookFilterPopoverTableViewCell 
        else {
            return UITableViewCell()
        }
        
        cell.bind(filter: VocaBookData.shared.filters[indexPath.row])
        return cell
    }
    
    
}

extension VocaBookFilterPopoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VocaBookData.shared.filters[indexPath.row].isSelected = !VocaBookData.shared.filters[indexPath.row].isSelected
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
