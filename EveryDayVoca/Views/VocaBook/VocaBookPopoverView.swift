//
//  VocaBookVocaListOptionView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/18/24.
//

import UIKit

final class VocaBookPopoverView: BaseView {
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.evBackground
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
