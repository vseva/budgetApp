//
//  Formatter.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 14.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "

        return formatter
    }()
}
