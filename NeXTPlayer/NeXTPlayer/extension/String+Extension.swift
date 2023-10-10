//
//  String+Extension.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import Foundation

extension String {
    static func formattedDate(value: String) -> String {
        let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormatterGetter.date(from: value) else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}
