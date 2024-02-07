//
//  FestivalCell.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/04.
//

import UIKit

final class FestivalCell: UITableViewCell {
    
    static let identifier = "FestivalCell"
    
    // MARK: - Components

    private let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.addArrangedSubview(titleLabel)
        sv.addArrangedSubview(dateLabel)
        sv.addArrangedSubview(addressLabel)
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    
    override func prepareForReuse() {
        DispatchQueue.main.async { [weak self] in
            self?.mainImageView.image = UIImage()
        }
    }
    
    // MARK: - Configure
    
    private func configureCell() {
        contentView.backgroundColor = .white
        self.selectionStyle = .none
    }
    
    func setupData(_ festival: Festival) {
        let startDate = festival.eventStartDate.convertContentDate()
        let endDate = festival.eventEndDate.convertContentDate()
        
        DispatchQueue.main.async {
            self.mainImageView.setImage(to: festival.imageURLString)
            self.titleLabel.text = festival.title
            self.dateLabel.text = "\(startDate) ~ \(endDate)"
            self.addressLabel.text = festival.addr1
        }
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(stackView)
    }
    
    private func setLayout() {
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
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
}
