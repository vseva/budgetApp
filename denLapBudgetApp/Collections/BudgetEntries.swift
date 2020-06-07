//
//  Expenses.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


func getEntries(completion: @escaping ([BudgetEntryItem]) -> Void) {
    let url = URL(string: AppConstants.apiEntries)!
    var request = URLRequest(url: url)

    request.setValue("auth=zitugtK15KhCK2X0I7d436L3dsT6AIKI2we0UsIw", forHTTPHeaderField: "Cookie")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
    @Published var itemsAreLoaded = false
    
    func getEntriesCompletion(_ fetchedItems: [BudgetEntryItem]) {
        DispatchQueue.main.async {
            self.items.append(contentsOf: fetchedItems)
            self.itemsAreLoaded = true
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
