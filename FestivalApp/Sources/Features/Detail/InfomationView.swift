//
//  InfomationView.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

class InfomationView: UIView {
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Components
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
    }
    
    private func setLayout() {
        
    }

    
    // MARK: - Data
    
    func setupData(_ festival: Festival) {
        networkManager.fetchDetailInfomation(contentID: festival.contentid) { infomations in
            self.titleLabel.text = infomations.first?.infoname
            self.dateLabel.text = festival.eventStartDate
            self.infoLabel.text = infomations.first?.infotext
        }
    }
}
