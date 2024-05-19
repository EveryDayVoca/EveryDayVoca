//
//  BasicCustomAlertViewController.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/20/24.
//

import UIKit

protocol CustomAlertDelegate {
    func confirm()
}

class BasicCustomAlertViewController: BaseViewController {
    
    // MARK: - properties
    
    private var basicCustomAlert: BasicCustomAlertView!
    var delegate: CustomAlertDelegate?
    
    // MARK: - life cycles
    override func loadView() {
        basicCustomAlert = BasicCustomAlertView()
        
        view = UIView()
        view.addSubview(basicCustomAlert)
    }
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureStyle() {
        view.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(-30)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    override func bind() {
        basicCustomAlert.button.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }
    
    @IBAction func tappedConfirmButton() {
        self.dismiss(animated: true) {
            self.delegate?.confirm()
        }
    }
}
