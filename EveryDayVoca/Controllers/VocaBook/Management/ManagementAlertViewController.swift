//
//  ManagementAlertViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/20/24.
//

import UIKit

final class ManagementAlertViewController: BaseViewController {
    
    // MARK: - properties
    private let managementAlertView = ManagementAlertView()
    private let coreDataManager = VocaCoreDataManager.shared
    
    var completion: (() -> ())?
    
    // MARK: - life cycles
    override func loadView() {
        view = managementAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
    }
    
    // MARK: - methods
    private func configureAddTarget() {
        managementAlertView.addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
        managementAlertView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    @objc private func tappedAddButton() {
        if let deckName = managementAlertView.messageTextField.text, !deckName.isEmpty {
            coreDataManager.createVocaDeckData(vocaDeckName: deckName)
            completion!()
            
            dismiss(animated: false)
        }
    }
    
    @objc private func tappedCancelButton() {
        dismiss(animated: false)
    }
}
