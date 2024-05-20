//
//  StudyViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

final class StudyViewController: BaseViewController {
    
    // MARK: - properties
    private let studyView = StudyView()
    
    private let minimumLineSpacing: CGFloat = 16
    
    // MARK: - life cycles
    override func loadView() {
        view = studyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    private func configureAddTarget() {
        studyView.backBarButtonItem.target = self
        studyView.backBarButtonItem.action = #selector(tappedBackBarButtonItem)
        
        studyView.plusBarButtonItem.target = self
        studyView.plusBarButtonItem.action = #selector(tappedPlusBarButtonItem)
    }
    
    @objc private func tappedBackBarButtonItem() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedPlusBarButtonItem() {
        let studyAlertVC = StudyAlertViewController()
        studyAlertVC.modalPresentationStyle = .overFullScreen
        
        present(studyAlertVC, animated: false)
    }
    
    override func configureStyle() {
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.titleView = studyView.titleLabel
        navigationItem.leftBarButtonItem = studyView.backBarButtonItem
        navigationItem.rightBarButtonItem = studyView.plusBarButtonItem
    }
    
    override func configureDelegate() {
        studyView.collectionView.delegate = self
        studyView.collectionView.dataSource = self
        studyView.collectionView.register(StudyCell.self, forCellWithReuseIdentifier: "StudyCell")
    }
    
    override func bind() {
        
    }
}

extension StudyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
}

extension StudyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyCell", for: indexPath) as? StudyCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension StudyViewController: UICollectionViewDelegateFlowLayout {
    // 셀의 크기
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - minimumLineSpacing * 5) / 2
        return CGSize(width: size, height: size)
    }
    
    // 지정 된 섹션의 행 사이 최소 간격
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing * 2
    }
    
    // 지정 된 섹션의 셀 사이 최소 간격
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
}
