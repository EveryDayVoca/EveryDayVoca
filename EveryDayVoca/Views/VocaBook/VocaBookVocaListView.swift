//
//  VocaBookVocaListView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/16/24.
//

import UIKit

final class VocaBookVocaListView: BaseView {
    
    // MARK: - Properties

    private let vocaBookSelectionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    private let vocaBookSelectionLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.evText
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    private let vocaBookSelectionImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor.evText
    }
    
    private let tableOptionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    private lazy var tableFilterButton = UIButton(configuration: makeButtonConfiguration(title: "모든 단어", titleSize: 14))
    
    private lazy var tableDisplayOptionButton = UIButton(configuration: makeButtonConfiguration(title: "단어 + 의미", titleSize: 14))
    
    private let tableItemCountLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.gray100
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    private let vocaListTableView = UITableView().then {
        $0.backgroundColor = UIColor.evBackground
    }
    
    
    
    // MARK: - Methods
    
    override func configureConstraints() {
        vocaBookSelectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        vocaBookSelectionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        vocaBookSelectionImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        tableOptionView.snp.makeConstraints {
            $0.top.equalTo(vocaBookSelectionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(vocaListTableView)
            $0.height.equalTo(25)
        }
        
        tableFilterButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
//            $0.width.equalTo(91)
        }
        
        tableDisplayOptionButton.snp.makeConstraints {
            $0.leading.equalTo(tableFilterButton.snp.trailing).offset(10)
            $0.verticalEdges.equalToSuperview()
//            $0.width.equalTo(96)
        }
        
        tableItemCountLabel.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        vocaListTableView.snp.makeConstraints {
            $0.top.equalTo(tableOptionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(26)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureHierarchy() {
        [vocaBookSelectionView,
         tableOptionView,
         vocaListTableView].forEach { self.addSubview($0) }
        
        [vocaBookSelectionLabel,
         vocaBookSelectionImage].forEach { vocaBookSelectionView.addSubview($0) }
        
        [tableFilterButton,
         tableDisplayOptionButton,
         tableItemCountLabel].forEach { tableOptionView.addSubview($0) }
    }
    
    private func makeButtonConfiguration(title: String, titleSize: CGFloat) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        // title
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.font = UIFont.pretendard(size: titleSize, weight: .light)
        // image
        config.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")?.applyingSymbolConfiguration(.init(pointSize: titleSize - 3))
        config.imagePadding = 4
        // color
        config.background.backgroundColor = UIColor.blue100
        config.baseForegroundColor = .white
        // frame
        config.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 8.0, bottom: 1.0, trailing: 8.0)
        config.background.cornerRadius = 5
        return config
    }
}
