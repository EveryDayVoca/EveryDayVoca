//
//  VocaBookPopoverViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/19/24.
//

import UIKit

class VocaBookFilterPopoverViewController: BaseViewController {

    // MARK: - Properties
    
    private let vocaBookPopoverView = VocaBookPopoverView()
    private let filters: [Status] = [.difficult, .ambiguous, .memorized]
    
    
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
        
        self.vocaBookPopoverView.tableView.register(VocaBookFilterPopoverTableViewCell.self, forCellReuseIdentifier: VocaBookFilterPopoverTableViewCell.identifier)
        
        self.vocaBookPopoverView.tableView.dataSource = self
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
        
        cell.bind(status: filters[indexPath.row])
        
        return cell
    }
    
    
}
