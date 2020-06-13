//
//  TimePeriodMonthsView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct TimePeriodMonthsView: View {
    @EnvironmentObject var appState: AppState
    let year: String
    
    var body: some View {
        VStack {
            List {
                Text("month1")
                Text("month2")
            }
        }.navigationBarTitle(year)
    }
}

struct TimePeriodMonthsView_Previews: PreviewProvider {
    static var previews: some View {
        TimePeriodMonthsView(year: "2020").environmentObject(AppState())
    }
}
