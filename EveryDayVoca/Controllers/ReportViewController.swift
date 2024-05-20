//
//  ReportViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

class ReportViewController: BaseViewController {
    
    let reportView = ReportView()
    
    let titleLabel = UILabel().then {
        $0.text = "통계"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = .evText
        $0.textAlignment = .center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = self.reportView
        
        self.navigationItem.titleView = titleLabel
    }
    

}
