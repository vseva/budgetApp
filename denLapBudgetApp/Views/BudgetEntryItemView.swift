//
//  BudgetEntryItemView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 06.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI

struct BudgetEntryItemView: View {
    var item: BudgetEntryItem
    var hideDate: Bool
    var categoryTitle: String {
        if item.type == AppConstants.expenseEntryType {
            return AppConstants.budgetExpensesCategoriesTypes[item.category]!
        }
        
        return AppConstants.budgetIncomeCategoriesTypes[item.category]!
    }

    var body: some View {
        VStack(alignment: .leading) {
            if !hideDate {
                Text(getFormattedDate(item.date, AppConstants.humanDateFormat))
                    .font(.system(size: 12))
            }
            Text(categoryTitle)
                .font(.system(size: 14))
            HStack {
                Text(item.description).font(.headline)
                Spacer()
                Text("\(Int(item.amount)!.formattedWithSeparator) ₽").font(.headline)
            }
        }
    }
}

struct BudgetEntryItemView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntryItemView(item: BudgetEntryItem.example, hideDate: false)
    }
}
