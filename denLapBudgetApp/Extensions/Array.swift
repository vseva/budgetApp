//
//  Array.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


extension Array where Element: Hashable {
    var distinct: Array {
        var buffer = Array()
        var added = Set<Element>()

        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }

        return buffer
    }
}
