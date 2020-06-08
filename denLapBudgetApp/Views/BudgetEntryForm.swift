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
    @EnvironmentObject var appState: AppState
    @State private var newEntry = BudgetEntryItem.blank
    
    var submitDisabled: Bool {
        return newEntry.name == "" || newEntry.amount == ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Type", selection: $newEntry.type) {
                    ForEach(AppConstants.budgetEntryTypesList, id: \.self) { item in
                        Text(AppConstants.budgetEntryTypes[item]!)
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
                
                TextField("Name", text: $newEntry.name)
                
                TextField("Amount, ₽", text: $newEntry.amount)
                    .keyboardType(.numberPad)
                
                Button(action: {
                    self.budgetEntries.add(item: self.newEntry)
                    self.appState.selectedTab = 0
                }) {
                    Text("Save")
                }.disabled(submitDisabled)
                
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
        BudgetEntryForm()
            .environmentObject(BudgetEntries())
            .environmentObject(AppState())
    }
}
