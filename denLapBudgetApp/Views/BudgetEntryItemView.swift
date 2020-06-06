//
//  ExpenseItem.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 06.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntryItemView: View {
    var item: ExpenseItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(AppConstants.budgetEntryOwnerTypes[item.owner]!)
            HStack {
                Text(item.name).font(.headline)
                Spacer()
                Text("\(item.amount) ₽")
            }
        }
    }
}

struct BudgetEntryItemView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntryItemView(item: ExpenseItem.example)
    }
}
