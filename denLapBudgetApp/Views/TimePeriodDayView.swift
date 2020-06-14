//
//  TimePeriodDayView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct TimePeriodDayView: View {
    @EnvironmentObject var appState: AppState
    let year: String
    let month: String
    let day: String
    
    func deleteItems(at offsets: IndexSet) {
        let dayItems = appState.dayItems(self.year, self.month, self.day)

        offsets.forEach {
            appState.remove(dayItems[$0])
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(appState.dayItems(year, month, day), id: \._id) { item in
                    NavigationLink(destination: BudgetEntryForm(entry: item, isEditing: true)) {
                        BudgetEntryItemView(item: item, hideDate: true)
                    }
                }.onDelete(perform: deleteItems)
            }
        }.navigationBarTitle("\(AppConstants.humanMonth[month]!) \(String(Int(day)!)), \(year)")
    }
}

struct TimePeriodDayView_Previews: PreviewProvider {
    static var previews: some View {
        TimePeriodDayView(year: "2020", month: "01", day: "01")
            .environmentObject(AppState())
    }
}
