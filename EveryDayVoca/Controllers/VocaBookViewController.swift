//
//  VocaBookViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

final class VocaBookViewController: BaseViewController {
    
    // MARK: - Properties
    private let vocaBookVocaListView = VocaBookVocaListView()
    private let titleLabel = UILabel().then {
        $0.text = "나의 단어 사전"
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
        $0.textColor = UIColor.evText
        $0.textAlignment = .center
    }
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = vocaBookVocaListView
        self.navigationItem.titleView = titleLabel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
