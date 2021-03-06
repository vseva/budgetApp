//
//  TimePeriodYearsView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct TimePeriodYearsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            List {
                ForEach(appState.yearsList(), id: \.self) { year in
                    NavigationLink(destination: TimePeriodYearMonthsView(year: year)) {
                        HStack {
                            Text(year)
                            Spacer()
                            Text(self.appState.totalInPeriod(year: year))
                        }
                    }
                }
            }
        }
        .navigationBarTitle(appState.getSectionTitleByTab())
    }
}

struct TimePeriodYearsView_Previews: PreviewProvider {
    static var previews: some View {
        TimePeriodYearsView().environmentObject(AppState())
    }
}
