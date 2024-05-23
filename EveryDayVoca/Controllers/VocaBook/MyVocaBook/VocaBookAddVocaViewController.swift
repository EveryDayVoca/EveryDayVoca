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
    
    var completion: (() -> ())?

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
        configureAddTarget()
    }
    
    override func configureDelegate() {
        super.configureDelegate()
    }
    
    override func bind() {
        let vocaDecks = VocaCoreDataManager.shared.getVocaDeckData()
        vocaBookAddVocaView.bind(vocaDecks: vocaDecks)
    }
    
    private func configureAddTarget() {
        // 취소하기
        vocaBookAddVocaView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        
        // 추가하기
        vocaBookAddVocaView.addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    @objc func tappedCancelButton() {
        self.dismiss(animated: true)
    }
    
    @objc func tappedAddButton(_ sender: UIButton) {
        // 1. 데이터 다 작성됐는지 확인
        guard let english = vocaBookAddVocaView.englishTextField.text,
              let korean = vocaBookAddVocaView.koreanTextField.text,
              let vocaDeck = vocaBookAddVocaView.vocaBookSelectPopupButton.titleLabel?.text,
              !english.isEmpty,
              !korean.isEmpty
        else {
            // 2-1. 데이터 다 안 채웠을 경우 경고 Alert
            self.showAlertIfDataIncomplete(english: vocaBookAddVocaView.englishTextField.text, korean: vocaBookAddVocaView.koreanTextField.text)
            return
        }
        
        // 2-2. 데이터 다 채웠을 경우 coreData 업데이트
        VocaCoreDataManager.shared.createVocaData(english: english, korean: korean, vocaDeck: vocaDeck)
        VocaCoreDataManager.shared.updateVocaDeckCount(vocaDeck)
        
        // 3. 저장 성공 Alert 띄우기
        dismissModalAlert(title: "단어가 저장되었습니다.", message: nil, vc: self)
    }
    
    
    func showAlertIfDataIncomplete(english: String?, korean: String?) {
        if english == nil || english == "" {
            showAlert(title: "단어를 입력하세요", message: nil, vc: self)
            
        } else if korean == nil || korean == "" {
            showAlert(title: "의미를 입력하세요", message: nil, vc: self)
        }
    }
    
    
    func showAlert(title: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
    
    func dismissModalAlert(title: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) { [self, weak vc] _ in
            completion!()
            vc?.dismiss(animated: true)
        }
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
    
    
}
