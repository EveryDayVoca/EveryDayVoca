//
//  StudyAlertViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/20/24.
//

import UIKit

final class StudyAlertViewController: BaseViewController {
    
    // MARK: - properties
    private let studyAlertView = StudyAlertView()
    
    // MARK: - life cycles
    override func loadView() {
        view = studyAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
    }
    
    // MARK: - methods
    private func configureAddTarget() {
        studyAlertView.addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
        studyAlertView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    @objc private func tappedAddButton() {
        
    }
    
    @objc private func tappedCancelButton() {
        dismiss(animated: false)
    }
}
