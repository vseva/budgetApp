//
//  TimePeriodYearMonthsView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct TimePeriodYearMonthsView: View {
    @EnvironmentObject var appState: AppState
    let year: String
    
    var body: some View {
        VStack {
            List {
                ForEach(appState.yearMonthsList(year), id: \.self) { month in
                    NavigationLink(destination: TimePeriodMonthDaysView(year: self.year, month: month)) {
                        HStack {
                            Text(AppConstants.humanMonth[month]!)
                            Spacer()
                            Text(self.appState.totalInPeriod(year: self.year, month: month))
                        }
                    }
                }
            }
        }.navigationBarTitle(year)
    }
}

struct TimePeriodYearMonthsView_Previews: PreviewProvider {
    static var previews: some View {
        TimePeriodYearMonthsView(year: "2020").environmentObject(AppState())
    }
}
