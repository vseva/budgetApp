//
//  ExpenseForm.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntryForm: View {
    @EnvironmentObject var expenses: Expenses
    @EnvironmentObject var appState: AppState
    
    @State private var newExpense = ExpenseItem(
        name: "",
        amount: "",
        type: AppConstants.expenseEntryType,
        owner: AppConstants.natashaEntryOwnerType
    )
    
    var submitDisabled: Bool {
        return newExpense.name == "" || newExpense.amount == ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Type", selection: $newExpense.type) {
                    ForEach(AppConstants.budgetEntryTypesList, id: \.self) { item in
                        Text(AppConstants.budgetEntryTypes[item]!)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Owner", selection: $newExpense.owner) {
                    ForEach(AppConstants.budgetEntryOwnersList, id: \.self) { item in
                        Text(AppConstants.budgetEntryOwnerTypes[item]!)
                    }
                }
                
                TextField("Name", text: $newExpense.name)
                
                TextField("Amount, ₽", text: $newExpense.amount)
                    .keyboardType(.numberPad)
                
                Button(action: {
                    self.expenses.add(item: self.newExpense)
                    self.appState.selectedTab = 0
                }) {
                    Text("Save")
                }.disabled(submitDisabled)
                
            }
            .navigationBarTitle("Add")
        }
        .onDisappear {
            self.newExpense = ExpenseItem(
                name: "",
                amount: "",
                type: AppConstants.expenseEntryType,
                owner: AppConstants.natashaEntryOwnerType
            )
        }
    }
}

struct BudgetEntryForm_Previews: PreviewProvider {
    static let expenses = Expenses()
    static let appState = AppState()

    static var previews: some View {
        BudgetEntryForm()
            .environmentObject(expenses)
            .environmentObject(appState)
    }
}
