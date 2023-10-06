//
//  Int+Extension.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import Foundation
extension Int {
    func formattedDuration(time: Int) -> String {
        let timeInSeconds = time / 1000
        
        let interval = TimeInterval(timeInSeconds)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: interval) ?? ""
    }
}
