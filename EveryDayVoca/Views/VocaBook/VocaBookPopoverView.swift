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
        
        self.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(88)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        self.addSubview(tableView)
    }
    
}
