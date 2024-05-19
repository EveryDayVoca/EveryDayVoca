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
    
    var titleText: String = ""
    var subtitleText: String = ""
    var buttonTitleText: String = ""
    
    private var basicCustomAlert: BasicCustomAlertView!
    var delegate: CustomAlertDelegate?
    
    
    // MARK: - life cycles
    
    override func loadView() {
        basicCustomAlert = BasicCustomAlertView()
    }
    
    override func viewDidLoad() {
        view = UIView()
        view.addSubview(basicCustomAlert)
        
        super.viewDidLoad()
    }
    
    
    // MARK: - methods
    
    override func configureStyle() {
        basicCustomAlert.backgroundColor = .clear
        basicCustomAlert.title.text = titleText
        basicCustomAlert.subtitle.text = subtitleText
        basicCustomAlert.button.setTitle(buttonTitleText, for: .normal)
        
        basicCustomAlert.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(-30)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalToSuperview().multipliedBy(0.22)
        }
    }
    
    override func bind() {
        basicCustomAlert.button.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }
    
    @objc func tappedConfirmButton() {
        self.dismiss(animated: true) {
            self.delegate?.confirm()
        }
    }
}
