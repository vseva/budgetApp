//
//  Binding.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 08.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation
import SwiftUI


extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
