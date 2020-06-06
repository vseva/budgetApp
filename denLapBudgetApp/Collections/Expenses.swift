//
//  Expenses.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()

//    var total: Int {
//        if items.count > 0 {
//            return items.reduce(0) { $0 + $1.amount }
//        } else {
//            return 0
//        }
//    }

    func getSectionItems(type: String) -> [ExpenseItem] {
        return self.items.filter {
            $0.type == type
        }
    }
    
    func add(item: ExpenseItem) {
        items.append(item)
    }
}
