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
        ZStack {
            TabView(selection: $appState.selectedTab) {
                NavigationView {
                        BudgetEntryForm(entry: BudgetEntryItem.blank, isEditing: false)
                    }
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .tag(AppConstants.AppTabs.add)
                    .navigationViewStyle(StackNavigationViewStyle())
                
                NavigationView {
                        TimePeriodYearsView()
                    }
                    .tabItem {
                        Image(systemName: "tray.and.arrow.up")
                        Text(AppConstants.budgetSectionTitles[AppConstants.expenseEntryType]!)
                    }
                    .tag(AppConstants.AppTabs.expenses)
                    .navigationViewStyle(StackNavigationViewStyle())

                NavigationView {
                        TimePeriodYearsView()
                    }
                    .tabItem {
                        Image(systemName: "tray.and.arrow.down")
                        Text(AppConstants.budgetSectionTitles[AppConstants.incomeEntryType]!)
                    }
                    .tag(AppConstants.AppTabs.income)
                    .navigationViewStyle(StackNavigationViewStyle())
                
//                NavigationView {
//                        BudgetEntriesListView(type: AppConstants.expenseEntryType)
//                    }
//                    .tabItem {
//                        Image(systemName: "tray.and.arrow.up")
//                        Text(AppConstants.budgetSectionTitles[AppConstants.expenseEntryType]!)
//                    }
//                    .tag(AppConstants.AppTabs.expensesAll)
//                    .navigationViewStyle(StackNavigationViewStyle())
//
//                NavigationView {
//                        BudgetEntriesListView(type: AppConstants.incomeEntryType)
//                    }
//                    .tabItem {
//                        Image(systemName: "tray.and.arrow.down")
//                        Text(AppConstants.budgetSectionTitles[AppConstants.incomeEntryType]!)
//                    }
//                    .tag(AppConstants.AppTabs.incomeAll)
//                    .navigationViewStyle(StackNavigationViewStyle())

            }

            if !appState.itemsAreLoaded {
                LoaderContainerView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppState())
    }
}
