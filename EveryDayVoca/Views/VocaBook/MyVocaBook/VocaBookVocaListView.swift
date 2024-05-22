//
//  VocaBookVocaListView.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/16/24.
//

import UIKit

final class VocaBookVocaListView: VocaBookBaseView {
    
    //MARK: - Properties
    
    let filterImage = UIImage(systemName: "line.3.horizontal.decrease")!
    let eyeImage = UIImage(systemName: "eye")!
    
    private let tableOptionView = UIView().then {
        $0.backgroundColor = .none
    }
    
    lazy var tableFilterButton = UIButton(
        configuration:
            returnTableOptionButtonConfiguration(
                title: "필터", titleSize: 14, image: filterImage)
    )
    
    lazy var tableDisplayOptionButton = UIButton(
        configuration:
            returnTableOptionButtonConfiguration(
                title: "보기 옵션", titleSize: 14, image: eyeImage)
    )
    
    private let tableItemCountLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.gray100
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 12, weight: .medium)
    }
    
    let vocaListTableView = UITableView().then {
        $0.backgroundColor = UIColor.evBackground
        $0.separatorStyle = .none
    }
    
    
    // MARK: - Methods
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [tableOptionView,
         vocaListTableView].forEach { self.customView.addSubview($0) }
        
        [tableFilterButton,
         tableDisplayOptionButton,
         tableItemCountLabel].forEach { tableOptionView.addSubview($0) }
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        tableOptionView.snp.makeConstraints {
            $0.top.equalTo(customView).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(26)
            $0.height.equalTo(25)
        }
        
        tableFilterButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
        }
        
        tableDisplayOptionButton.snp.makeConstraints {
            $0.leading.equalTo(tableFilterButton.snp.trailing).offset(10)
            $0.verticalEdges.equalToSuperview()
           }
   
           tableItemCountLabel.snp.makeConstraints {
               $0.trailing.verticalEdges.equalToSuperview()
               $0.width.equalTo(64)
           }
   
           vocaListTableView.snp.makeConstraints {
               $0.top.equalTo(tableOptionView.snp.bottom).offset(16)
               $0.horizontalEdges.equalToSuperview().inset(10)
               $0.bottom.equalTo(self.customView)
           }
       }
    
    
    func bind(vocaBook: String) {
        currentVocaBookLabel.text = vocaBook
    }
    
       private func returnTableOptionButtonConfiguration(title: String, titleSize: CGFloat, image: UIImage) -> UIButton.Configuration {
           var config = UIButton.Configuration.plain()
           // title
           config.attributedTitle = AttributedString(title)
           config.attributedTitle?.font = UIFont.pretendard(size: titleSize, weight: .light)
           // image
           config.image = image.applyingSymbolConfiguration(.init(pointSize: titleSize - 3))
           config.imagePadding = 4
           // color
           config.baseForegroundColor = .white
           config.background.backgroundColor = UIColor.blue100
           // frame
           config.contentInsets = NSDirectionalEdgeInsets(top: 1.0, leading: 8.0, bottom: 1.0, trailing: 8.0)
           config.background.cornerRadius = 5
           return config
       }
    
}
