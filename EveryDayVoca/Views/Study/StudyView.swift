//
//  StudyView.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/21/24.
//

import UIKit
import DGCharts

final class StudyView: BaseView {
    
    // MARK: - properties
    let titleLabel = UILabel().then {
        $0.configureText(alignment: .center, font: .pretendard(size: 17, weight: .semibold), text: "학습하기")
    }
    
    private let contentLabel = UILabel().then {
        $0.configureText(alignment: .center, font: .pretendard(size: 17, weight: .bold), numberOfLines: 0)
    }
    
    private let vocaShadowView = UIView().then {
        $0.configureShadow()
    }
    
    private let vocaContainerView = UIView().then {
        $0.configureView(color: .evBackground, cornerRadius: 12)
    }
    
    private let vocaTitleLabel = UILabel().then {
        $0.configureText(alignment: .center, font: .pretendard(size: 17, weight: .semibold), text: "오늘 학습할 단어")
    }
    
    private let vocaStepLabel = UILabel().then {
        $0.configureText(alignment: .center, font: .pretendard(size: 15, weight: .medium), text: "단계")
    }
    
    private let vocaLevelLabel = UILabel().then {
        $0.configureView(color: .gray50, clipsToBounds: true, cornerRadius: 14)
        $0.configureText(alignment: .center, font: .pretendard(size: 15, weight: .medium), text: "Lv. ")
    }
    
    private let vocaTargetLabel = UILabel().then {
        $0.configureText(alignment: .center, font: .pretendard(size: 15, weight: .medium), text: "학습 목표")
    }
    
    private let vocaCountLabel = UILabel().then {
        $0.configureView(color: .gray50, clipsToBounds: true, cornerRadius: 14)
        $0.configureText(alignment: .center, font: .pretendard(size: 15, weight: .medium), text: " 개")
    }
    
    let vocaListButton = UIButton().then {
        $0.configureView(color: .evBackground, cornerRadius: 15)
        $0.configureText(color: .blue100, font: .pretendard(size: 20, weight: .semibold), text: "단어 리스트")
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.blue100.cgColor
    }
    
    let vocaStudyButton = UIButton().then {
        $0.configureView(color: .blue100, cornerRadius: 15)
        $0.configureText(color: .evBackground, font: .pretendard(size: 20, weight: .semibold), text: "학습하기")
    }
    
    private let infoShadowView = UIView().then {
        $0.configureShadow()
    }
    
    private let infoContainerView = UIView().then {
        $0.configureView(color: .evBackground, cornerRadius: 12)
    }
    
    private let infoTitleLabel = UILabel().then {
        $0.configureText(alignment: .center, font: .pretendard(size: 17, weight: .semibold), text: "오늘 학습 정보")
    }
    
    private let infoPieChart = PieChartView().then {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 25, weight: .heavy),
                                                         .foregroundColor: UIColor.evText]
        $0.centerAttributedText = NSAttributedString(string: "0%", attributes: attributes)
        $0.legend.enabled = false
        $0.rotationEnabled = false
        $0.drawEntryLabelsEnabled = false
        $0.highlightPerTapEnabled = false
        $0.holeRadiusPercent = 0.63
        $0.setExtraOffsets(left: -16, top: -16, right: -16, bottom: -16)
    }
    
    private let infoMemorizedView = UIView().then {
        $0.configureView(color: .blue100, cornerRadius: 5)
    }
    
    private let infoAmbiguousView = UIView().then {
        $0.configureView(color: .blue50, cornerRadius: 5)
    }
    
    private let infoDifficultView = UIView().then {
        $0.configureView(color: .blue10, cornerRadius: 5)
    }
    
    private let infoNoneView = UIView().then {
        $0.configureView(color: .gray50, cornerRadius: 5)
    }
    
    private let infoMemorizedLabel = UILabel().then {
        $0.configureText(font: .pretendard(size: 16, weight: .medium), text: "외웠어요")
    }
    
    private let infoAmbiguousLabel = UILabel().then {
        $0.configureText(font: .pretendard(size: 16, weight: .medium), text: "애매해요")
    }
    
    private let infoDifficultLabel = UILabel().then {
        $0.configureText(font: .pretendard(size: 16, weight: .medium), text: "어려워요")
    }
    
    private let infoNoneLabel = UILabel().then {
        $0.configureText(font: .pretendard(size: 16, weight: .medium), text: "미학습")
    }
    
    private let infoMemorizedCountLabel = UILabel().then {
        $0.configureText(alignment: .right, font: .pretendard(size: 16, weight: .medium), text: "0개")
    }
    
    private let infoAmbiguousCountLabel = UILabel().then {
        $0.configureText(alignment: .right, font: .pretendard(size: 16, weight: .medium), text: "0개")
    }
    
    private let infoDifficultCountLabel = UILabel().then {
        $0.configureText(alignment: .right, font: .pretendard(size: 16, weight: .medium), text: "0개")
    }
    
    private let infoNoneCountLabel = UILabel().then {
        $0.configureText(alignment: .right, font: .pretendard(size: 16, weight: .medium), text: "0개")
    }
    
    private lazy var vocaButtonStackView = UIStackView().then {
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private lazy var infoViewStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
    }
    
    private lazy var infoLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private lazy var infoCountLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .trailing
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        self.addSubview(contentLabel)
        self.addSubview(vocaShadowView)
        self.addSubview(infoShadowView)
        self.vocaShadowView.addSubview(vocaContainerView)
        self.infoShadowView.addSubview(infoContainerView)
        self.vocaContainerView.addSubview(vocaTitleLabel)
        self.vocaContainerView.addSubview(vocaStepLabel)
        self.vocaContainerView.addSubview(vocaLevelLabel)
        self.vocaContainerView.addSubview(vocaTargetLabel)
        self.vocaContainerView.addSubview(vocaCountLabel)
        self.vocaContainerView.addSubview(vocaButtonStackView)
        self.infoContainerView.addSubview(infoTitleLabel)
        self.infoContainerView.addSubview(infoPieChart)
        self.infoContainerView.addSubview(infoViewStackView)
        self.infoContainerView.addSubview(infoLabelStackView)
        self.infoContainerView.addSubview(infoCountLabelStackView)
        self.vocaButtonStackView.addArrangedSubview(vocaListButton)
        self.vocaButtonStackView.addArrangedSubview(vocaStudyButton)
        self.infoViewStackView.addArrangedSubview(infoMemorizedView)
        self.infoViewStackView.addArrangedSubview(infoAmbiguousView)
        self.infoViewStackView.addArrangedSubview(infoDifficultView)
        self.infoViewStackView.addArrangedSubview(infoNoneView)
        self.infoLabelStackView.addArrangedSubview(infoMemorizedLabel)
        self.infoLabelStackView.addArrangedSubview(infoAmbiguousLabel)
        self.infoLabelStackView.addArrangedSubview(infoDifficultLabel)
        self.infoLabelStackView.addArrangedSubview(infoNoneLabel)
        self.infoCountLabelStackView.addArrangedSubview(infoMemorizedCountLabel)
        self.infoCountLabelStackView.addArrangedSubview(infoAmbiguousCountLabel)
        self.infoCountLabelStackView.addArrangedSubview(infoDifficultCountLabel)
        self.infoCountLabelStackView.addArrangedSubview(infoNoneCountLabel)
    }
    
    override func configureConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        vocaShadowView.snp.makeConstraints {
            $0.top.equalTo(self.contentLabel.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        infoShadowView.snp.makeConstraints {
            $0.top.equalTo(self.vocaShadowView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.infoNoneView.snp.bottom).offset(36)
        }
        
        vocaContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        infoContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vocaTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        vocaStepLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.vocaLevelLabel.snp.centerY)
            $0.leading.equalTo(self.vocaListButton.snp.leading).offset(24)
        }
        
        vocaLevelLabel.snp.makeConstraints {
            $0.top.equalTo(self.vocaTitleLabel.snp.bottom).offset(24)
            $0.trailing.equalTo(self.vocaListButton.snp.trailing)
            $0.width.equalTo(74)
            $0.height.equalTo(28)
        }
        
        vocaTargetLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.vocaCountLabel.snp.centerY)
            $0.leading.equalTo(self.vocaStudyButton.snp.leading).offset(8)
        }
        
        vocaCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.vocaTitleLabel.snp.bottom).offset(24)
            $0.trailing.equalTo(self.vocaStudyButton.snp.trailing)
            $0.width.equalTo(74)
            $0.height.equalTo(28)
        }
        
        vocaButtonStackView.snp.makeConstraints {
            $0.top.equalTo(vocaCountLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        infoPieChart.snp.makeConstraints {
            $0.top.equalTo(self.infoTitleLabel.snp.bottom).offset(38)
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(34)
            $0.width.height.equalTo(140)
        }
        
        infoMemorizedView.snp.makeConstraints {
            $0.width.height.equalTo(10)
        }
        
        infoAmbiguousView.snp.makeConstraints {
            $0.width.height.equalTo(10)
        }
        
        infoDifficultView.snp.makeConstraints {
            $0.width.height.equalTo(10)
        }
        
        infoNoneView.snp.makeConstraints {
            $0.width.height.equalTo(10)
        }
        
        infoViewStackView.snp.makeConstraints {
            $0.centerY.equalTo(self.infoPieChart.snp.centerY)
            $0.leading.equalTo(self.infoPieChart.snp.trailing).offset(16)
        }
        
        infoLabelStackView.snp.makeConstraints {
            $0.top.equalTo(self.infoViewStackView.snp.top).offset(-5)
            $0.leading.equalTo(self.infoViewStackView.snp.trailing).offset(16)
            $0.bottom.equalTo(self.infoViewStackView.snp.bottom).offset(5)
        }
        
        infoCountLabelStackView.snp.makeConstraints {
            $0.top.equalTo(self.infoLabelStackView.snp.top)
            $0.trailing.equalToSuperview().inset(32)
            $0.bottom.equalTo(self.infoLabelStackView.snp.bottom)
        }
    }
    
    func bind(pieChartData: PieChartData, allStatus: [Int], user: User) {
        let target = Int(Double(allStatus[0]) / Double(allStatus.reduce(0) { $0 + $1 }) * 100)
        
        if target == 0 {
            contentLabel.text = "\(user.name)님, 학습을 시작해볼까요?!"
        } else if target == 100 {
            contentLabel.text = "\(user.name)님, 오늘 학습을 완료하였습니다!\n축하드립니다"
        } else {
            contentLabel.text = "\(user.name)님, 오늘 학습 목표까지 \(100-target)% 남았습니다!\n학습을 마무리 해볼까요?"
        }
        
        vocaLevelLabel.text = "Lv. \(user.level)"
        vocaCountLabel.text = "\(user.amount)개"
        
        infoPieChart.data = pieChartData
        print(target)
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(size: 25, weight: .heavy),
                                                         .foregroundColor: UIColor.evText]
        infoPieChart.centerAttributedText = NSAttributedString(string: "\(target)%", attributes: attributes)
        
        infoMemorizedCountLabel.text = String("\(allStatus[0])개")
        infoAmbiguousCountLabel.text = String("\(allStatus[1])개")
        infoDifficultCountLabel.text = String("\(allStatus[2])개")
        infoNoneCountLabel.text = String("\(allStatus[3])개")
    }
}
