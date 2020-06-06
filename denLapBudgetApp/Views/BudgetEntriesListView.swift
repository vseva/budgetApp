//
//  ExpensesList.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntriesListView: View {
    @EnvironmentObject var expenses: Expenses
    
    var type: String
    
    func deleteItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach (expenses.items, id: \.self) { item in
                    BudgetEntryItemView(item: item)
                }.onDelete(perform: deleteItems)
            }
            .navigationBarTitle("test")
            
            Spacer()
        }
    }
}

struct BudgetEntriesListView_Previews: PreviewProvider {
    static let expenses = Expenses()

    static var previews: some View {
        BudgetEntriesListView(type: "BOoo").environmentObject(expenses)
    }
}
