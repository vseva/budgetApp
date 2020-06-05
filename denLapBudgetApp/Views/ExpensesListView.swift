//
//  ExpensesList.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct ExpensesListView: View {
    @EnvironmentObject var expenses: Expenses
    
    func deleteItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach (expenses.items, id: \.self) { item in
                    Text(item.name)
                }.onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Expenses")
            
            Spacer()
        }
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static let expenses = Expenses()

    static var previews: some View {
        ExpensesListView().environmentObject(expenses)
    }
}
