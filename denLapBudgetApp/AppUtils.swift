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
    static func getDistinctPeriods(_ entries: [BudgetEntryItem], _ period: String ) -> [String] {
        let periodFormats = [
            "year": "yyyy",
            "month": "MM",
            "day": "dd",
        ];
        
        var periodsList: [String] = []
        
        entries.forEach { item in
            periodsList.append(getFormattedDate(item.date, periodFormats[period]!))
        }
        
        return periodsList.distinct.sorted {
            $0 > $1
        }
    }
}
