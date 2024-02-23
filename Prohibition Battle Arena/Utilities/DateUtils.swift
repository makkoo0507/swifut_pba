//
//  DateUtils.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/22.
//

import Foundation


func formatDate(_ date: Date?) -> String {
    if let unwrappedDate = date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: unwrappedDate)
    } else {
        return ""
    }
}
func parseDate(_ dateString: String, format: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: dateString)
}

func getDay(_ dateString: String) -> String {
    let date = parseDate(dateString, format: "yyyy-MM-dd")
    let calendar = Calendar.current
        let day = calendar.component(.day, from: date ?? Date())
        return "\(day)"
}

func getProgress(start:String,end:String) -> Double {
    let startDate = parseDate(start, format: "yyyy-MM-dd") ?? Date()
    let endDate = parseDate(end, format: "yyyy-MM-dd") ?? Date()
    let totalTimeInterval = endDate.timeIntervalSince(startDate)
    let currentTimeInterval = Date().timeIntervalSince(startDate)
    return min(max(currentTimeInterval / totalTimeInterval, 0.0), 1.0)
}
