//
//  String+Extension.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/12.
//

import Foundation

extension String {
    func convertContentDate() -> String {
        var convertedString = self
        convertedString.insert(".", at: self.index(self.startIndex, offsetBy: 4))
        convertedString.insert(".", at: self.index(self.startIndex, offsetBy: 7))
        return convertedString
    }
    
    func changeBrTag() -> String {
        let changedString = self.replacingOccurrences(of: "<br>", with: "\n")
        return changedString
    }
}
