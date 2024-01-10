//
//  ContentCell.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

final class ContentCell: UITableViewCell {
    static let identifier = "ContentCell"
    
    var mainView: InfomationView!
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainView = InfomationView()
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func addSubviews() {
        contentView.addSubview(mainView)
    }
    
    func setLayout() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
