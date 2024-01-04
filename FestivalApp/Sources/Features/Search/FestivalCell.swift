//
//  FestivalCell.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/04.
//

import UIKit

class FestivalCell: UITableViewCell {
    static let identifier = "FestivalCell"
    
    // MARK: - Components

    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemRed
        return iv
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.addArrangedSubview(titleLabel)
        sv.addArrangedSubview(dateLabel)
        sv.addArrangedSubview(addressLabel)
        return sv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Configure
    
    func configureCell() {
        contentView.backgroundColor = .white
        self.selectionStyle = .none
    }
    
    func setupData(_ festival: MockFestival) {
        mainImageView.image = UIImage(systemName: "scribble")
        titleLabel.text = festival.title
        dateLabel.text = "\(festival.eventStartDate) ~ \(festival.eventEndDate)"
        addressLabel.text = festival.address
    }
    
    // MARK: - Layout
    
    func addSubviews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(stackView)
    }
    
    func setLayout() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainImageView.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
