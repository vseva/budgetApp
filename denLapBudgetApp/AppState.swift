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
        //AppRequest.getEntries(completion: getEntriesCompletion)
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
        return self.items.firstIndex(where: { $0._id == item._id })!
    }
    
    func getEntriesTypeByTab() -> String {
        let type = self.selectedTab == AppConstants.AppTabs.expenses
            ? AppConstants.expenseEntryType
            : AppConstants.incomeEntryType

        return type
    }
    
    func getSectionTitleByTab() -> String {
        let title = self.selectedTab == AppConstants.AppTabs.expenses
            ? AppConstants.expensesTitle
            : AppConstants.incomeTitle
        
        return title
    }
    
    func yearsList() -> [String] {
        let items = self.getSectionItems(type: self.getEntriesTypeByTab())
        
        return DateUtils.getDistinctPeriods(items, "year")
    }
    
    func getStartOfYear(_ year: String) -> Date {
        return getDateFromString("\(year)-01-01T00:00:00Z")
    }
    
    func getEndOfYear(_ year: String) -> Date {
        return getDateFromString("\(year)-12-31T23:59:59Z")
    }
    
    func getStartOfMonth(_ year: String, _ month: String) -> Date {
        return getDateFromString("\(year)-\(month)-01T00:00:00Z")
    }
    
    func getEndOfMonth(_ year: String, _ month: String) -> Date {
        return getDateFromString("\(year)-\(month)-31T23:59:59Z")
    }
    
    func getYearItems(_ year: String) -> [BudgetEntryItem] {
        let items = self.getSectionItems(type: self.getEntriesTypeByTab())
        let start = getStartOfYear(year)
        let end = getEndOfYear(year)
        let filteredItems = items.filter {
            $0.date >= start && $0.date <= end
        };
        
        return filteredItems
    }
    
    func yearMonthsList(_ year: String) -> [String] {
        let filteredItems = getYearItems(year)
        
        return DateUtils.getDistinctPeriods(filteredItems, "month")
    }
    
    func getMonthItems(_ year: String, _ month: String) -> [BudgetEntryItem] {
        let items = self.getSectionItems(type: self.getEntriesTypeByTab())
        let start = getStartOfMonth(year, month)
        let end = getEndOfMonth(year, month)
        let filteredItems = items.filter {
            $0.date >= start && $0.date <= end
        };
        
        return filteredItems
    }
    
    func monthDaysList(_ year: String, _ month: String) -> [String] {
        let filteredItems = getMonthItems(year, month);
        
        return DateUtils.getDistinctPeriods(filteredItems, "day")
    }
    
    
    func dayItems(_ year: String, _ month: String, _ day: String) -> [BudgetEntryItem] {
        let items = self.getSectionItems(type: self.getEntriesTypeByTab())
        let startOfDay = getDateFromString("\(year)-\(month)-\(day)T00:00:00Z")
        let endOfDay = getDateFromString("\(year)-\(month)-\(day)T23:59:59Z")
        let filteredItems = items.filter {
            $0.date >= startOfDay && $0.date <= endOfDay
        };
        
        return filteredItems.sorted {
            $0.date > $1.date
        }
    }
    
    func totalInPeriod(year: String, month: String? = "", day: String? = "") -> String {
        var filteredItems: [BudgetEntryItem] = []
        
        if month != "" {
            if day != "" {
                filteredItems = dayItems(year, month!, day!)
            } else {
                filteredItems = getMonthItems(year, month!)
            }
        } else {
            filteredItems = getYearItems(year)
        }
        
        let total = filteredItems.reduce(0, { acc, cur in
            acc + Int(cur.amount)!
        })
        
        return "\(total.formattedWithSeparator) ₽"
    }
}
