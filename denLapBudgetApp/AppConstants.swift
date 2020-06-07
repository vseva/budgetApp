//
//  AppConstants.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 06.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


struct AppConstants {
    static let expenseEntryType = "expense"
    static let incomeEntryType = "income"
    static let budgetEntryTypes: [String: String] = [
        expenseEntryType: "Expense",
        incomeEntryType: "Income",
    ]
    static let budgetSectionTitles: [String: String] = [
        expenseEntryType: "Expenses",
        incomeEntryType: "Income",
    ]
    static let budgetEntryTypesList: [String] = [
        expenseEntryType,
        incomeEntryType,
    ]
    
    static let natashaEntryOwnerType = "natasha"
    static let sevaEntryOwnerType = "seva"
    static let budgetEntryOwnerTypes: [String: String] = [
        natashaEntryOwnerType: "Natasha",
        sevaEntryOwnerType: "Seva",
    ]
    static let budgetEntryOwnersList: [String] = [
        natashaEntryOwnerType,
        sevaEntryOwnerType,
    ]
    
    static let apiUri = "https://den-lap-budget-api.now.sh/api"
    //static let apiUri = "http://localhost:3000/api"
    static let apiGetEntries = "\(apiUri)/entries"
    static let apiAddEntry = "\(apiUri)/add"
    static let apiAuthCookie = "auth=zitugtK15KhCK2X0I7d436L3dsT6AIKI2we0UsIw"
}
