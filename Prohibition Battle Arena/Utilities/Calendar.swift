//
//  Calender.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/13.
//

import Foundation
extension Calendar {
    
    func getDate(year:Int,month:Int,day:Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components ) ?? Date()
    }
    
    func firstDayOfMonth(year: Int, month: Int) -> Date {
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = 1
        return Calendar.current.date(from: components) ?? Date()
        }
    func startOfMonth(for date:Date) -> Date? {
        let comps = dateComponents([.month, .year], from: date)
        return self.date(from: comps)
    }
    func daysInMonth(for date:Date) -> Int? {
        return range(of: .day, in: .month, for: date)?.count
    }
    func weeksInMonth(for date:Date) -> Int? {
        return range(of: .weekOfMonth, in: .month, for: date)?.count
    }
    func year(for date: Date) -> Int? {
        let comps = dateComponents([.year], from: date)
        return comps.year
    }
    
    func month(for date: Date) -> Int? {
        let comps = dateComponents([.month], from: date)
        return comps.month
    }
    
    func day(for date: Date) -> Int? {
        let comps = dateComponents([.day], from: date)
        return comps.day
    }
    
    func weekday(for date: Date) -> Int? {
        let comps = dateComponents([.weekday], from: date)
        return comps.weekday
    }
}

func createCalendarDates(_ date: Date) -> [CalendarDates] {
    var days = [CalendarDates]()
    
    let startOfMonth = Calendar.current.startOfMonth(for: date)
    let daysInMonth = Calendar.current.daysInMonth(for: date)
    
    guard let daysInMonth = daysInMonth, let startOfMonth = startOfMonth else { return [] }
    
    for day in 0..<daysInMonth {
        days.append(CalendarDates(date: Calendar.current.date(byAdding: .day, value: day, to: startOfMonth)))
    }
    
    guard let firstDay = days.first,
          let lastDay = days.last,
          let firstDate = firstDay.date,
          let lastDate = lastDay.date,
          let firstDateWeekday = Calendar.current.weekday(for: firstDate),
          let lastDateWeekday = Calendar.current.weekday(for: lastDate) else { return [] }
    
    _ = firstDateWeekday - 1
    let lastWeekEmptyDays = 7 - lastDateWeekday
    for _ in 0..<lastWeekEmptyDays {
        days.append(CalendarDates(date: nil))
    }
    return days
}

func getCalendarDates(year:Int,month:Int) -> [CalendarStringDates] {
    let date = Calendar.current.firstDayOfMonth(year: year, month: month)
    var days = [CalendarStringDates]()
    
    let startOfMonth = Calendar.current.startOfMonth(for: date)
    let daysInMonth = Calendar.current.daysInMonth(for: date)
    
    guard let daysInMonth = daysInMonth, let startOfMonth = startOfMonth else { return [] }
    
    for day in 0..<daysInMonth {
        let calDay = Calendar.current.date(byAdding: .day, value: day, to: startOfMonth)
        days.append(
            CalendarStringDates(date:formatDate(calDay))
        )
    }
    return days
}

struct CalendarDates: Identifiable {
    var id = UUID()
    var date: Date?
}

struct CalendarStringDates: Identifiable {
    var id = UUID()
    var date: String?
}
