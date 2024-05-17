//
//  WordListTableViewCell.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/16/24.
//

import UIKit

// -------------------------------------
// 데이터 파일 생성 전까지 임시로 사용
enum Status {
    case difficult
    case ambiguous
    case memorized
}
struct Voca {
    let english: String
    let korean: String
    let pronunciation: String
    let status: Status
    let vocaBook: String
}
// -------------------------------------


final class VocaListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let statusDotImage = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")
        $0.contentMode = .scaleAspectFit
    }
    
    private let statusTextLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.evText
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    private let vocaBookLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.evText
        $0.font = UIFont.pretendard(size: 12, weight: .regular)
    }
    
    private let englishLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 20, weight: .semibold)
    }
    
    private let koreanLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.evText
        $0.numberOfLines = 0
        $0.font = UIFont.pretendard(size: 20, weight: .medium)
    }
    
    
    
    // MARK: - Life cycles
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Methods
    private func configureUI() {
        self.backgroundColor = UIColor.evBackground
    }
    
    private func configureConstraints() {
        
        let horizontalEdge = 22
        let verticalEdge = 16
        
        statusDotImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(horizontalEdge)
            $0.top.equalToSuperview().offset(verticalEdge)
            $0.size.equalTo(7)
        }
        
        statusTextLabel.snp.makeConstraints {
            $0.leading.equalTo(statusDotImage.snp.trailing).offset(5)
            $0.top.equalTo(statusDotImage)
        }
        
        
        vocaBookLabel.snp.makeConstraints {
            $0.leading.equalTo(statusTextLabel.snp.trailing).offset(10)
            $0.top.equalTo(statusTextLabel)
            $0.trailing.equalToSuperview().inset(horizontalEdge)
        }
        
        
        englishLabel.snp.makeConstraints {
            $0.leading.equalTo(statusDotImage)
            $0.top.equalTo(statusDotImage.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().inset(verticalEdge)
        }
        
        
        koreanLabel.snp.makeConstraints {
            $0.leading.equalTo(englishLabel.snp.trailing).offset(10)
            $0.top.equalTo(englishLabel)
            $0.trailing.equalToSuperview().inset(horizontalEdge)
            $0.bottom.equalToSuperview().inset(verticalEdge)
        }
        
        
        func configureHierarchy() {
            [statusDotImage,
             statusTextLabel,
             vocaBookLabel,
             englishLabel,
             koreanLabel].forEach { contentView.addSubview($0) }
        }
        
        
        func bind(voca: Voca) {
            switch voca.status {
            case .difficult:
                statusDotImage.tintColor = UIColor.red100
                statusTextLabel.text = "어려워요"
            case .ambiguous:
                statusDotImage.tintColor = UIColor.yellow100
                statusTextLabel.text = "애매해요"
            case .memorized:
                statusDotImage.tintColor = UIColor.green100
                statusTextLabel.text = "외웠어요"
            }
            
            vocaBookLabel.text = voca.vocaBook
            
            englishLabel.text = voca.english
            
            koreanLabel.text = voca.korean
        }
        
    }
}
