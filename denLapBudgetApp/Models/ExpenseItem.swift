//
//  Expense.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


struct ExpenseItem: Codable, Equatable, Hashable {
    var name: String

    #if DEBUG
        static let example = ExpenseItem(
            name: "Maple French Toast"
        )
    #endif
}
