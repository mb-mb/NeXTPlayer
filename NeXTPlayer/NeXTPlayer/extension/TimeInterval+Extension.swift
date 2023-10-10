//
//  TimeInterval+Extension.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 08/10/23.
//

import Foundation
extension TimeInterval {
    func formatTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        if let formattedString = formatter.string(from: self) {
            return formattedString
        } else {
            return "00:00" // Default value if formatting fails
        }
    }
}
