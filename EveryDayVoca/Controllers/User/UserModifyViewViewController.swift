//
//  UserModifyViewViewController.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/22/24.
//

import UIKit

final class UserModifyViewController: BaseViewController {
    
    // MARK: - property
    private let userModifyView = UserModifyView()
    private let userView = UserView()
    
    private let firstPickerView = UIPickerView()
    private let secondPickerView = UIPickerView()
    
    private let level = ["Lv. 1", "Lv. 2", "Lv. 3", "Lv. 4", "Lv. 5"]
    private let counts = ["10개", "20개", "30개", "40개", "50개", "60개", "70개", "80개", "90개", "100개"]
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    var completion: (() -> ())?
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = self.userModifyView
        
        tapGesture()
        dismissPickerView()
    }
    
    // MARK: - method
    override func configureStyle() {
        let titleLabel = UILabel().then {
            $0.text = "프로필 수정"
            $0.font = UIFont.pretendard(size: 17, weight: .bold)
            $0.textColor = UIColor.evText
            $0.textAlignment = .center
        }
        navigationItem.titleView = titleLabel
    }
    
    override func configureDelegate() {
        firstPickerView.delegate = self
        secondPickerView.delegate = self
    }
    
    override func bind() {
        userModifyView.levelTextField.inputView = firstPickerView
        userModifyView.learningAmountTextField.inputView = secondPickerView
        
        let user = userDefaultsManager.fetchUser()
        userModifyView.bind(user: user)
    }
    
    private func tapGesture() {
        userModifyView.doneEditButton.addTarget(self, action: #selector(tappedDoneEditButton), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
        userModifyView.profileImage.addGestureRecognizer(tapGesture)
        userModifyView.profileImage.isUserInteractionEnabled = true
    }
    
    @objc func tappedDoneEditButton() {
        let alert = UIAlertController(title: "프로필 수정", message: "변경 사항을 저장하시겠습니까?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            if userDefaultsManager.updateUser(user: userModifyView.fetchUser()) {
                completion!()
                self.navigationController?.popViewController(animated: true)
            } else {
                print("큰일인걸?")
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}


// MARK: - extension
extension UserModifyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) { () in
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.userModifyView.profileImage.image = img
        }
    }
    
    @objc func touchToPickPhoto() {
        let picker = UIImagePickerController().then {
            $0.sourceType = .photoLibrary
            $0.allowsEditing = true
            $0.delegate = self
        }
        self.present(picker, animated: true)
    }
}


extension UserModifyViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstPickerView {
            return level.count
        } else {
            return counts.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstPickerView {
            return level[row]
        } else {
            return counts[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstPickerView {
            self.userModifyView.levelTextField.text = level[row]
        } else {
            self.userModifyView.learningAmountTextField.text = counts[row]
        }
    }
    
    func dismissPickerView() {
        let button = UIBarButtonItem().then {
            $0.title = "선택"
            $0.style = .plain
            $0.target = self
            $0.action = #selector(self.action)
        }
        
        let toolBar = UIToolbar().then {
            $0.sizeToFit()
            $0.setItems([button], animated: false)
            $0.isUserInteractionEnabled = true
        }
        
        self.userModifyView.levelTextField.inputAccessoryView = toolBar
        self.userModifyView.learningAmountTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        self.view.endEditing(true)
    }
    
}
