//
//  HomeView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ExpensesListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Expenses")
                }
            ExpenseForm()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let expenses = Expenses()

    static var previews: some View {
        HomeView().environmentObject(expenses)
    }
}
