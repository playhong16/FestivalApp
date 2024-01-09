//
//  StringFormatter.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/09.
//

import Foundation

struct StringFormatter {
    static func convertCustomStringDate(from dateString: String) -> String {
        var convertedString = dateString
        convertedString.insert(".", at: dateString.index(dateString.startIndex, offsetBy: 4))
        convertedString.insert(".", at: dateString.index(dateString.startIndex, offsetBy: 7))
        return convertedString
    }
}
