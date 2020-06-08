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

func getStringFromDate(date: Date) -> String {
    let formatter = ISO8601DateFormatter()

    return formatter.string(from: date)
}

// ISO 8601 date format: "2016-08-17T04:23:00Z"
func getDateFromString(dateString: String) -> Date {
    let formatter = ISO8601DateFormatter()

    return formatter.date(from: dateString)!
}

func getHumanDateFormat(date: Date) -> String {
    let formatter = DateFormatter()
    
    formatter.dateFormat = "MMM d, yyyy"
    
    return formatter.string(from: date)
}
