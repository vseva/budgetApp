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
            BudgetEntriesListView(type: "bsba")
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Expenses")
                }
                .tag(0)
            BudgetEntryForm()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }
                .tag(1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let expenses = Expenses()
    static let appState = AppState()

    static var previews: some View {
        HomeView()
            .environmentObject(expenses)
            .environmentObject(appState)
    }
}
