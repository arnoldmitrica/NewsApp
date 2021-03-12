//
//  DateExt.swift
//  newsapp
//
//  Created by Arnold Mitricã on 11.03.2021.
//

import Foundation

extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    static func timeFromLshToRhs (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

extension TimeInterval {
    var formatted: String {
        let endingDate = Date()
        let startingDate = endingDate.addingTimeInterval(-self)
        let calendar = Calendar.current

        let componentsNow = calendar.dateComponents([.hour, .minute, .second], from: startingDate, to: endingDate)
        if let hour = componentsNow.hour, let minute = componentsNow.minute, let seconds = componentsNow.second {
            //return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", seconds))"
            if hour < 2{
                if minute < 2 {
                    if minute == 0 {
                        return "about \(String(format: "%02d", seconds)) seconds ago "
                    }
                    return "\(String(format: "%02d", minute)) min. and \(String(format: "%02d", seconds)) sec. ago "
                }
                if hour == 0 {
                    return "\(String(format: "%02d", minute)) minutes ago "
                }
                return "about \(String(format: "%02d", hour)) hours and \(String(format: "%02d", minute)) minutes ago "
            }
            if hour > 24 {
                return "\(String(format: "%02d", hour/24)) days, \(hour % 24) h ago"
            }
            return "about \(String(format: "%02d", hour + 1)) hours ago"
    
        } else {
            return ""
        }
    }
}
