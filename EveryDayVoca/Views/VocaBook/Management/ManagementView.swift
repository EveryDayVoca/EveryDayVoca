//
//  ManagementView.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/19/24.
//

import UIKit

final class ManagementView: BaseView {
    
    // MARK: - properties
    let titleLabel = UILabel().then {
        $0.text = "단어장"
        $0.textColor = .evText
        $0.textAlignment = .center
        $0.font = UIFont.pretendard(size: 17, weight: .semibold)
    }
    
    let plusBarButtonItem = UIBarButtonItem().then {
        $0.image = .plus.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .evText
        $0.style = .done
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.contentInset = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
