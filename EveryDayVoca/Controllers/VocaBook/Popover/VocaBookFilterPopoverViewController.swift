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
    var filters: [Filter] = [Filter(status: .difficult, isSelected: true),
                             Filter(status: .ambiguous, isSelected: true),
                             Filter(status: .memorized, isSelected: true),
                             Filter(status: .none, isSelected: true)]
    
    
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
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaBookFilterPopoverTableViewCell.identifier) as? VocaBookFilterPopoverTableViewCell 
        else {
            return UITableViewCell()
        }
        
        cell.bind(filter: filters[indexPath.row])
//        cell.selectionStyle = .none
        print("load cell???????")
        return cell
    }
    
    
}

extension VocaBookFilterPopoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filters[indexPath.row].isSelected = !filters[indexPath.row].isSelected
        tableView.reloadRows(at: [indexPath], with: .automatic)
        print("filters: \(filters)")
    }
    
}
