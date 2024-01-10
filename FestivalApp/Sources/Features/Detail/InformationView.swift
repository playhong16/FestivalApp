//
//  InfomationView.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

final class InfomationView: UIView {
    
    // MARK: - Components
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(
            arrangedSubviews: [nameStackView, dateStackView, contentStackView, telephoneNumberStackView])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 20
        return sv
    }()
    
    lazy var nameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameTitleLabel, nameTextLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "축제 이름"
        return label
    }()
    
    let nameTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "제목"
        return label
    }()
    
    lazy var dateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [dateTitleLabel, dateTextLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "축제 날짜"
        return label
    }()
    
    let dateTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "날짜"
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [contentTitleLabel, contentTextLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "축제 소개"
        return label
    }()
    
    let contentTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "소개"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var telephoneNumberStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [telephoneNumberTitleLabel, telephoneNumberTextLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let telephoneNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "문의하기"
        return label
    }()
    
    let telephoneNumberTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "문의 번호"
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubviews()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        self.addSubview(stackView)
    }
    
    private func setLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }

    
    // MARK: - Data
    
    func setupData(_ festival: Festival, information: Information) {
        let startDate = StringFormatter.convertCustomStringDate(from: festival.eventStartDate)
        let endDate = StringFormatter.convertCustomStringDate(from: festival.eventEndDate)
        DispatchQueue.main.async {
            self.nameTextLabel.text = festival.title
            self.dateTextLabel.text = "\(startDate) ~ \(endDate)"
            self.contentTextLabel.text = information.infotext
            self.telephoneNumberTextLabel.text = festival.tel
        }
    }
}
