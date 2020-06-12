//
//  BudgetEntryForm.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntryForm: View {
    @EnvironmentObject var budgetEntries: BudgetEntries
    @State private var newEntry = BudgetEntryItem.blank
    
    var submitDisabled: Bool {
        return newEntry.description == "" || newEntry.amount == ""
    }
    
    func onEntryTypeChange(_ id: String) {
        if id == AppConstants.incomeEntryType {
            self.newEntry.category = AppConstants.defaultBudgetIncomeCategory
        } else {
            self.newEntry.category = AppConstants.defaultBudgetExpenseCategory
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Type", selection: $newEntry.type.onChange(self.onEntryTypeChange)) {
                    ForEach(AppConstants.budgetEntryTypesList, id: \.self) { item in
                        Text(AppConstants.budgetEntryTypes[item]!).tag(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Owner", selection: $newEntry.owner) {
                    ForEach(AppConstants.budgetEntryOwnersList, id: \.self) { item in
                        Text(AppConstants.budgetEntryOwnerTypes[item]!)
                    }
                }
                
                DatePicker(
                    "Date",
                    selection: $newEntry.date,
                    in: ...Date(),
                    displayedComponents: .date
                )

                Picker("Category", selection: $newEntry.category) {
                    if newEntry.type == AppConstants.expenseEntryType {
                        ForEach(AppConstants.budgetExpensesCategoriesList, id: \.self) { item in
                            Text(AppConstants.budgetExpensesCategoriesTypes[item]!)
                        }
                    } else {
                        ForEach(AppConstants.budgetIncomeCategoriesList, id: \.self) { item in
                            Text(AppConstants.budgetIncomeCategoriesTypes[item]!)
                        }
                    }
                }
                
                TextField("Description", text: $newEntry.description)
                
                TextField("Vendor", text: $newEntry.vendor)
                
                TextField("Amount, ₽", text: $newEntry.amount)
                    .keyboardType(.numberPad)
                
                Section {
                    Button(action: {
                        self.budgetEntries.add(item: self.newEntry)
                        self.budgetEntries.selectedTab = AppConstants.AppTabs.expenses
                    }) {
                        Text("Save")
                    }.disabled(submitDisabled)
                }
            }
            .navigationBarTitle("Add")
        }
        .onDisappear {
            self.newEntry = BudgetEntryItem.blank
        }
    }
}

struct BudgetEntryForm_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntryForm().environmentObject(BudgetEntries())
    }
}
