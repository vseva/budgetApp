//
//  BudgetEntriesListView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntriesListView: View {
    @EnvironmentObject var entries: BudgetEntries
    @State var alertVisible = false
    @State var responseText = ""
    
    var type: String
    
    var listTitle: String {
        return AppConstants.budgetSectionTitles[type]!
    }

    func deleteItems(at offsets: IndexSet) {
        entries.items.remove(atOffsets: offsets)
    }
    
    func showAlert(_ items: [BudgetEntryItem]) {
        self.entries.set(fetchedItems: items)
        self.alertVisible = true
    }

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(entries.getSectionItems(type: self.type), id: \.self) { item in
                        BudgetEntryItemView(item: item)
                    }.onDelete(perform: deleteItems)
                }
                .navigationBarTitle(listTitle)
                
                Spacer()
            }
        }
    }
}

struct BudgetEntriesListView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntriesListView(type: AppConstants.expenseEntryType)
            .environmentObject(BudgetEntries())
    }
}
