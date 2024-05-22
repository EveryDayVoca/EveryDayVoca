//
//  ManagementViewController.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/14/24.
//

import UIKit

final class ManagementViewController: BaseViewController {
    
    // MARK: - properties
    private let managementView = ManagementView()
    
    private let minimumLineSpacing: CGFloat = 16
    
    // MARK: - life cycles
    override func loadView() {
        view = managementView
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
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureDelegate() {
        managementView.collectionView.delegate = self
        managementView.collectionView.dataSource = self
        managementView.collectionView.register(ManagementCell.self, forCellWithReuseIdentifier: "ManagementCell")
    }
    
    private func configureNavigation() {
        navigationItem.titleView = managementView.titleLabel
        navigationItem.rightBarButtonItem = managementView.plusBarButtonItem
    }
    
    private func configureAddTarget() {
        managementView.plusBarButtonItem.target = self
        managementView.plusBarButtonItem.action = #selector(tappedPlusBarButtonItem)
    }
    
    @objc private func tappedPlusBarButtonItem() {
        let managementAlertVC = ManagementAlertViewController()
        managementAlertVC.modalPresentationStyle = .overFullScreen
        
        present(managementAlertVC, animated: false)
    }
}

extension ManagementViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
}

extension ManagementViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ManagementCell", for: indexPath) as? ManagementCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension ManagementViewController: UICollectionViewDelegateFlowLayout {
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
