//
//  SavedFestivalCell.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/15.
//

import UIKit

class SavedFestivalCell: UICollectionViewCell {
    static let identifier = "SavedFestivalCell"
    
    // MARK: - Components

    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
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
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let buttonImageConfig = UIImage.SymbolConfiguration(pointSize: 25)
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart", withConfiguration: buttonImageConfig), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: buttonImageConfig), for: .selected)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func addSubviews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(heartButton)
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
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
        
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure
    
    func configureCell() {
        contentView.backgroundColor = .white
    }
    
    // MARK: - Data
    
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
    
    // MARK: - Action
    
    @objc
    func heartButtonTapped(_ sender: UIButton) {
        heartButton.isSelected.toggle()
    }

}
