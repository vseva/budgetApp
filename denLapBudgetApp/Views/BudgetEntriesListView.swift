//
//  BudgetEntriesListView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntriesListView: View {
    @EnvironmentObject var appState: AppState
    @State var alertVisible = false
    @State var responseText = ""
    
    let type: String

    func deleteItems(at offsets: IndexSet) {
        let categoryItems = appState.getSectionItems(type: self.type)

        offsets.forEach {
            appState.remove(categoryItems[$0])
        }
    }

    var body: some View {
        VStack {
            List {
                ForEach(appState.getSectionItems(type: self.type), id: \._id) { item in
                    NavigationLink(destination: BudgetEntryForm(entry: item, isEditing: true)) {
                        BudgetEntryItemView(item: item, hideDate: false)
                    }
                }.onDelete(perform: deleteItems)
            }

            Spacer()
        }
        .navigationBarTitle(AppConstants.budgetSectionTitles[type]!)
    }
}

struct BudgetEntriesListView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntriesListView(type: AppConstants.expenseEntryType)
            .environmentObject(AppState())
    }
}
