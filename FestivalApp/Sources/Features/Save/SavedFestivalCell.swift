//
//  SavedFestivalCell.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/15.
//

import UIKit

class SavedFestivalCell: UICollectionViewCell {
    static let identifier = "SavedFestivalCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
