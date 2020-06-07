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
