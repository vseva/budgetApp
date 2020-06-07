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
    var name: String
    var owner: String
    var type: String
    

    #if DEBUG
        static let example = BudgetEntryItem(
            id: "",
            amount: "23",
            name: "Maple French Toast",
            owner: "natasha",
            type: "expense"
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
        
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let owner = json["owner"] as? String else {
            throw SerializationError.missing("owner")
        }
        
        guard let type = json["type"] as? String else {
            throw SerializationError.missing("type")
        }

        self.id = id
        self.amount = amount
        self.name = name
        self.owner = owner
        self.type = type
    }
}
