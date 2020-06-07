//
//  Expenses.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


func getEntries(completion: @escaping ([BudgetEntryItem]) -> Void) {
    let session = URLSession.shared
    let url = URL(string: AppConstants.apiEntries)!

    let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Response error", error!)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            if response != nil {
                print("Wrong response", response!)
            } else {
                print("Empty response")
            }
            return
        }
        
        guard let mime = response?.mimeType, mime == "application/json" else {
            print("Wrong MIME type")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                var budgetEntries: [BudgetEntryItem] = []

                if let entries = json["results"] as? Array<[String: Any]> {
                    try entries.forEach {
                        let budgetEntry = try BudgetEntryItem(json: $0)
                        budgetEntries.append(budgetEntry)
                    }
                    
                }

                completion(budgetEntries)
            }
        } catch let error as NSError {
            print("JSON error: \(error.localizedDescription)")
        }
    }
    
    task.resume()
}

class BudgetEntries: ObservableObject {
    @Published var items = [BudgetEntryItem]()
    
    func getEntriesCompletion(_ fetchedItems: [BudgetEntryItem]) {
        DispatchQueue.main.async {
            self.items.append(contentsOf: fetchedItems)
        }
    }
    
    init() {
        getEntries(completion: getEntriesCompletion)
    }

    func getSectionItems(type: String) -> [BudgetEntryItem] {
        return self.items.filter {
            $0.type == type
        }
    }
    
    func set(fetchedItems: [BudgetEntryItem]) {
        items = fetchedItems
    }
    
    func add(item: BudgetEntryItem) {
        items.append(item)
    }
}
