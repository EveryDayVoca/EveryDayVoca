//
//  VocaBookPopoverViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/19/24.
//

import UIKit

class VocaBookStatusFilterPopoverViewController: BaseViewController {

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
    
    override func configureDelegate() {
        super.configureDelegate()
        self.vocaBookPopoverView.tableView.dataSource = self
    }
}

extension VocaBookStatusFilterPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VocaBookStatusFilterPopoverTableViewCell.identifier) as? VocaBookStatusFilterPopoverTableViewCell else { return UITableViewCell() }
        
        cell.bind(status: filters[indexPath.row])
        
        return cell
    }
    
    
}
