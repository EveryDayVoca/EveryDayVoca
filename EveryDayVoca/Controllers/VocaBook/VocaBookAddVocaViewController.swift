//
//  VocaBookAddVocaViewController.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/20/24.
//

import UIKit

class VocaBookAddVocaViewController: BaseViewController {
    
    // MARK: - Properties
    let vocaBookAddVocaView = VocaBookAddVocaView()
    

    // MARK: - Life Cycles
    
    override func loadView() {
        view = vocaBookAddVocaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - Methods
    override func configureStyle() {
        super.configureStyle()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
    }
    
    override func bind() {
        super.bind()
    }
    
}
