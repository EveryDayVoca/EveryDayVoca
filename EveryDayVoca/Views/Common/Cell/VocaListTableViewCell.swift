//
//  WordListTableViewCell.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/16/24.
//

import UIKit

final class VocaListTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: VocaListTableViewCell.self)
    
    // MARK: - Properties
    
    private let cellView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.shadowColor = UIColor.evText.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 8
        $0.backgroundColor = UIColor.evBackground
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.evBackground
        
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(cellView)
        
        [statusDotImage,
         statusTextLabel,
         vocaBookLabel,
         englishLabel,
         koreanLabel].forEach { cellView.addSubview($0) }
    }
    
    private func configureConstraints() {
        
        // 셀 높이(100) >= 95; 그림자+여백 높이(12*2) + cellView 높이(71)
        let shadowEdge = 12
        let horizontalEdge = 27
        let verticalEdge = 16
        
        cellView.snp.makeConstraints {
            $0.edges.equalTo(contentView).inset(shadowEdge)
        }
        
        statusDotImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(horizontalEdge)
            $0.centerY.equalTo(statusTextLabel)
            $0.size.equalTo(9)
        }
        
        statusTextLabel.snp.makeConstraints {
            $0.leading.equalTo(statusDotImage.snp.trailing).offset(5)
            $0.top.equalTo(cellView).offset(verticalEdge)
        }
        
        
        vocaBookLabel.snp.makeConstraints {
            $0.leading.equalTo(statusTextLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(statusTextLabel)
            $0.trailing.equalToSuperview().inset(horizontalEdge)
        }
        
        
        englishLabel.snp.makeConstraints {
            $0.leading.equalTo(statusDotImage)
            $0.top.equalTo(statusTextLabel.snp.bottom).offset(7)
            $0.bottom.equalToSuperview().inset(verticalEdge)
        }
        
        
        koreanLabel.snp.makeConstraints {
            $0.leading.equalTo(englishLabel.snp.trailing).offset(10)
            $0.top.equalTo(englishLabel)
            $0.trailing.equalToSuperview().inset(horizontalEdge)
            $0.bottom.equalToSuperview().inset(verticalEdge)
        }
        
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
        case .none:
            statusDotImage.tintColor = UIColor.gray100
            statusTextLabel.text = "미학습"
        }
        
        englishLabel.text = voca.english
        koreanLabel.text = voca.korean
        vocaBookLabel.text = voca.vocaBook
        
        print("voca.korean: \(voca.korean)")
    }
    
    
}
