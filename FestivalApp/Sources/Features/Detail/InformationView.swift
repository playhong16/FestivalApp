//
//  InfomationView.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

class InfomationView: UIView {
    
    // MARK: - Components
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, dateLabel, infoLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "제목"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "날짜"
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "정보"
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
        DispatchQueue.main.async {
            self.titleLabel.text = festival.title
            self.dateLabel.text = festival.eventStartDate
            self.infoLabel.text = information.infotext
        }
    }
}
