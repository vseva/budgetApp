//
//  HomeView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            BudgetEntriesListView(type: AppConstants.expenseEntryType)
                .tabItem {
                    Image(systemName: "tray.and.arrow.up")
                    Text(AppConstants.budgetSectionTitles[AppConstants.expenseEntryType]!)
                }
                .tag(0)
            BudgetEntryForm()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }
                .tag(1)

            BudgetEntriesListView(type: AppConstants.incomeEntryType)
                .tabItem {
                    Image(systemName: "tray.and.arrow.down")
                    Text(AppConstants.budgetSectionTitles[AppConstants.incomeEntryType]!)
                }
                .tag(2)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(BudgetEntries())
            .environmentObject(AppState())
    }
}
