//
//  AppState.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


class AppState: ObservableObject {
    @Published var items = [BudgetEntryItem]()
    @Published var itemsAreLoaded = false
    @Published var selectedTab = AppConstants.AppTabs.add
    @Published var itemIsSaving = false

    init() {
        AppRequest.getEntries(completion: getEntriesCompletion)
    }
    
    func getEntriesCompletion(_ fetchedItems: [BudgetEntryItem]) {
        DispatchQueue.main.async {
            self.items.append(contentsOf: fetchedItems)
            self.itemsAreLoaded = true
        }
    }
    
    func add(item: BudgetEntryItem) {
        self.itemIsSaving = true
        AppRequest.addEntry(budgetEntry: item, completion: addEntryCompletion)
    }
    
    func addEntryCompletion(_ newItem: BudgetEntryItem) {
        DispatchQueue.main.async {
            self.items.append(newItem)
            self.itemIsSaving = false
            
            if (newItem.type == AppConstants.expenseEntryType) {
                self.selectedTab = AppConstants.AppTabs.expenses
            } else {
                self.selectedTab = AppConstants.AppTabs.income
            }
        }
    }
    
    func update(item: BudgetEntryItem) {
        self.itemIsSaving = true
        AppRequest.updateEntry(budgetEntry: item, completion: updateEntryCompletion)
    }
    
    func updateEntryCompletion(_ updatedItem: BudgetEntryItem) {
        DispatchQueue.main.async {
            self.itemIsSaving = false
            self.items[self.getItemOffset(updatedItem)] = updatedItem
        }
    }
 
    func remove(_ item: BudgetEntryItem) {
        let deletingItemOffset = self.getItemOffset(item)

        func removeEntryCompletion() {
            DispatchQueue.main.async {
                self.items.remove(at: deletingItemOffset)
            }
        }

        AppRequest.removeEntry(
            budgetEntry: item,
            completion: removeEntryCompletion
        )
    }
    
    func getSectionItems(type: String) -> [BudgetEntryItem] {
        return self.items.filter{ $0.type == type }
    }
    
    func getItemOffset(_ item: BudgetEntryItem) -> Int {
        return self.items.firstIndex(where: { $0.id == item.id })!
    }
}
