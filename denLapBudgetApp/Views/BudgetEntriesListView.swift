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
    
    var listTitle: String {
        return AppConstants.budgetSectionTitles[type]!
    }

    func deleteItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.getSectionItems(type: self.type), id: \.self) { item in
                    BudgetEntryItemView(item: item)
                }.onDelete(perform: deleteItems)
            }
            .navigationBarTitle(listTitle)
            
            Spacer()
        }
    }
}

struct BudgetEntriesListView_Previews: PreviewProvider {
    static let expenses = Expenses()

    static var previews: some View {
        BudgetEntriesListView(type: AppConstants.expenseEntryType)
            .environmentObject(expenses)
    }
}
