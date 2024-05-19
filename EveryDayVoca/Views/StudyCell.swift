//
//  StudyCell.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/19/24.
//

import UIKit

final class StudyCell: BaseCollectionViewCell {
    
    // MARK: - properties
    private let vocaBookButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 24, weight: .semibold), .foregroundColor: UIColor.evText]
        let attributedTitle = NSAttributedString(string: "", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.backgroundColor = .evBackground
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowRadius = 12
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowPath = nil
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(vocaBookButton)
    }
    
    override func configureConstraints() {
        vocaBookButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind() {
        
    }
}
