//
//  ExpenseForm.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct ExpenseForm: View {
    @EnvironmentObject var expenses: Expenses
    @State private var newExpense = ExpenseItem(name: "")
    
    var submitDisabled: Bool {
        return newExpense.name == ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $newExpense.name)
                }
                
                Section {
                    Button(action: {
                        self.expenses.add(item: self.newExpense)
                    }) {
                        Text("Save")
                    }.disabled(submitDisabled)
                }
                
            }
            .navigationBarTitle("Add expense")
        }
    }
}

struct ExpenseForm_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseForm()
    }
}
