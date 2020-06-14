//
//  AppUtils.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 07.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


func prepareRequest(location: String) -> URLRequest {
    let url = URL(string: location)!
    var request = URLRequest(url: url)

    request.setValue(AppConstants.apiAuthCookie, forHTTPHeaderField: "Cookie")
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    
    return request
}


func getStringFromDate(_ date: Date) -> String {
    let formatter = ISO8601DateFormatter()

    return formatter.string(from: date)
}

func getDateFromString(_ dateString: String) -> Date {
    let formatter = ISO8601DateFormatter()

    return formatter.date(from: dateString)!
}

func getFormattedDate(_ date: Date, _ format: String) -> String {
    let formatter = DateFormatter()
    
    formatter.dateFormat = format
    
    return formatter.string(from: date)
}

// ISO 8601: "2016-08-17T04:23:00Z"
// "yyyy-MM-dd HH:mm:ss"
class DateUtils {
    static func getDistinctYears(_ entries: [BudgetEntryItem]) -> [String] {
        var years: [String] = []
        
        entries.forEach { item in
            years.append(getFormattedDate(item.date, "yyyy"))
        }
        
        return years.distinct.sorted {
            $0 > $1
        }
    }
    
    static func getDistinctYearMonths(_ entries: [BudgetEntryItem]) -> [String] {
        var months: [String] = []
        
        entries.forEach { item in
            months.append(getFormattedDate(item.date, "MM"))
        }
        
        return months.distinct.sorted {
            $0 > $1
        }
    }
    
    static func getDistinctMonthDays(_ entries: [BudgetEntryItem]) -> [String] {
        var days: [String] = []
        
        entries.forEach { item in
            days.append(getFormattedDate(item.date, "dd"))
        }
        
        return days.distinct.sorted {
            $0 > $1
        }
    }
}
