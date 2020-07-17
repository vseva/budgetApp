//
//  BudgetEntryForm.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntryForm: View {
    @EnvironmentObject var appState: AppState
    @State var entry: BudgetEntryItem
    let isEditing: Bool
    
    var submitDisabled: Bool {
        return entry.description == "" || entry.amount == "" || appState.itemIsSaving
    }
    
    var buttonText: String {
        if appState.itemIsSaving == true {
            return "Saving..."
        }

        if isEditing {
            return "Save"
        }

        return "Add"
    }
    
    func onEntryTypeChange(_ id: String) {
        if id == AppConstants.incomeEntryType {
            self.entry.category = AppConstants.defaultBudgetIncomeCategory
        } else {
            self.entry.category = AppConstants.defaultBudgetExpenseCategory
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Picker("Type", selection: $entry.type.onChange(self.onEntryTypeChange)) {
                    ForEach(AppConstants.budgetEntryTypesList, id: \.self) { item in
                        Text(AppConstants.budgetEntryTypes[item]!).tag(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Owner", selection: $entry.owner) {
                    ForEach(AppConstants.budgetEntryOwnersList, id: \.self) { item in
                        Text(AppConstants.budgetEntryOwnerTypes[item]!)
                    }
                }
                
                DatePicker(
                    "Date",
                    selection: $entry.date,
                    in: ...Date(),
                    displayedComponents: .date
                )

                Picker("Category", selection: $entry.category) {
                    if entry.type == AppConstants.expenseEntryType {
                        ForEach(AppConstants.budgetExpensesCategoriesList, id: \.self) { item in
                            Text(AppConstants.budgetExpensesCategoriesTypes[item]!)
                        }
                    } else {
                        ForEach(AppConstants.budgetIncomeCategoriesList, id: \.self) { item in
                            Text(AppConstants.budgetIncomeCategoriesTypes[item]!)
                        }
                    }
                }

                CustomTextfield(text: $entry.description, keyType: UIKeyboardType.default, placeHolder: "Description")
                CustomTextfield(text: $entry.vendor, keyType: UIKeyboardType.default, placeHolder: "Vendor")
                CustomTextfield(text: $entry.amount, keyType: UIKeyboardType.numberPad, placeHolder: "Amount, ₽")
                
                Section {
                    Button(action: {
                        if self.isEditing {
                            self.appState.update(item: self.entry)
                        } else {
                            self.appState.add(item: self.entry)
                        }
                    }) {
                        Text(buttonText)
                    }.disabled(submitDisabled)
                }
            }
            
            Spacer()
        }
        .navigationBarTitle(isEditing ? "Edit" : "Add")
    }
}

struct BudgetEntryForm_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntryForm(
            entry: BudgetEntryItem.blank,
            isEditing: true
        ).environmentObject(AppState())
    }
}
