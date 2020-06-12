//
//  BudgetEntryItem.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation
import SwiftUI


enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

struct BudgetEntryItem: Codable, Equatable, Hashable {
    var id: String
    var amount: String
    var category: String
    var date: Date
    var description: String
    var owner: String
    var type: String
    var vendor: String
    
    static let blank = BudgetEntryItem(
        id: "",
        amount: "",
        category: AppConstants.defaultBudgetExpenseCategory,
        date: Date(),
        description: "",
        owner: AppConstants.natashaEntryOwnerType,
        type: AppConstants.expenseEntryType,
        vendor: ""
    )

    #if DEBUG
        static let example = BudgetEntryItem(
            id: "",
            amount: "23",
            category: AppConstants.defaultBudgetExpenseCategory,
            date: getDateFromString(dateString: "2011-11-11T11:11Z"),
            description: "Макароны",
            owner: AppConstants.natashaEntryOwnerType,
            type: AppConstants.expenseEntryType,
            vendor: "Пятерочка"
        )
    #endif
}

extension BudgetEntryItem {
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        guard let amount = json["amount"] as? String else {
            throw SerializationError.missing("amount")
        }
        
        guard let category = json["category"] as? String else {
            throw SerializationError.missing("category")
        }
        
        guard let date = json["date"] as? String else {
            throw SerializationError.missing("date")
        }
        
        guard let description = json["description"] as? String else {
            throw SerializationError.missing("description")
        }
        
        guard let owner = json["owner"] as? String else {
            throw SerializationError.missing("owner")
        }
        
        guard let type = json["type"] as? String else {
            throw SerializationError.missing("type")
        }
        
        guard let vendor = json["vendor"] as? String else {
            throw SerializationError.missing("vendor")
        }

        self.id = id
        self.amount = amount
        self.category = category
        self.date = getDateFromString(dateString: date)
        self.description = description
        self.owner = owner
        self.type = type
        self.vendor = vendor
    }
}
