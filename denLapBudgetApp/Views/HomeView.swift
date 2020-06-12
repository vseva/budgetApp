//
//  HomeView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var budgetEntries: BudgetEntries

    var body: some View {
        ZStack {
            TabView(selection: $budgetEntries.selectedTab) {
                BudgetEntryForm()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }
                .tag(AppConstants.AppTabs.add)
                
                BudgetEntriesListView(type: AppConstants.expenseEntryType)
                    .tabItem {
                        Image(systemName: "tray.and.arrow.up")
                        Text(AppConstants.budgetSectionTitles[AppConstants.expenseEntryType]!)
                    }
                    .tag(AppConstants.AppTabs.expenses)

                BudgetEntriesListView(type: AppConstants.incomeEntryType)
                    .tabItem {
                        Image(systemName: "tray.and.arrow.down")
                        Text(AppConstants.budgetSectionTitles[AppConstants.incomeEntryType]!)
                    }
                    .tag(AppConstants.AppTabs.income)
            }

            if !budgetEntries.itemsAreLoaded {
                LoaderContainerView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(BudgetEntries())
    }
}
