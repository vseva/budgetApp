//
//  TimePeriodMonthDaysView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct TimePeriodMonthDaysView: View {
    @EnvironmentObject var appState: AppState
    let year: String
    let month: String
    
    var body: some View {
        VStack {
            List {
                ForEach(appState.monthDaysList(year, month), id: \.self) { day in
                    Text(day)
                }
            }
        }.navigationBarTitle("\(AppConstants.humanMonth[month]!) \(year)")
    }
}

struct TimePeriodMonthDaysView_Previews: PreviewProvider {
    static var previews: some View {
        TimePeriodMonthDaysView(year: "2020", month: "01")
            .environmentObject(AppState())
    }
}
