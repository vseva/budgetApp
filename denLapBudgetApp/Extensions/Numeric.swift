//
//  Numeric.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 14.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


extension Numeric {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? ""
    }
}
