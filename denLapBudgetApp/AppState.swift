//
//  AppState.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 05.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


func getEntries(completion: @escaping ([BudgetEntryItem]) -> Void) {
    let request = prepareRequest(location: AppConstants.apiGetEntries)

    URLSession.shared.dataTask(with: request) { data, response, error in
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
    }.resume()
}

func addEntry(budgetEntry: BudgetEntryItem, completion: @escaping (BudgetEntryItem) -> Void) {
    var request = prepareRequest(location: AppConstants.apiAddEntry)
    let jsonEncoder = JSONEncoder()

    jsonEncoder.dateEncodingStrategy = .iso8601
    
    guard let jsonData = try? jsonEncoder.encode(budgetEntry) else {
        print("Can not encode json")
        return
    }

    let httpBody = jsonData

    request.httpMethod = "POST"
    request.httpBody = httpBody
    
    URLSession.shared.dataTask(with: request) { data, response, error in
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
                if let newEntry = json["inserted"] as? [String: Any] {
                    let newBudgetEntry = try BudgetEntryItem(json: newEntry)
                    completion(newBudgetEntry)
                }
            }
        } catch let error as NSError {
            print("JSON error: \(error.localizedDescription)")
        }
    }.resume()
}


func removeEntry(
    budgetEntry: BudgetEntryItem,
    completion: @escaping () -> Void
) {
    var request = prepareRequest(location: AppConstants.apiRemoveEntry)
    let jsonEncoder = JSONEncoder()

    jsonEncoder.dateEncodingStrategy = .iso8601
    
    guard let jsonData = try? jsonEncoder.encode(budgetEntry) else {
        print("Can not encode json")
        return
    }

    let httpBody = jsonData

    request.httpMethod = "DELETE"
    request.httpBody = httpBody
    
    URLSession.shared.dataTask(with: request) { data, response, error in
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
                if let deletedEntryId = json["deleted"] as? String {
                    print("deletedEntryId", deletedEntryId)
                    completion()
                } else {
                    print("Entry was not deleted", json)
                }
            }
        } catch let error as NSError {
            print("JSON error: \(error.localizedDescription)")
        }
    }.resume()
}

class AppState: ObservableObject {
    @Published var items = [BudgetEntryItem]()
    @Published var itemsAreLoaded = false
    @Published var selectedTab = AppConstants.AppTabs.add

    init() {
        getEntries(completion: getEntriesCompletion)
    }
    
    func getEntriesCompletion(_ fetchedItems: [BudgetEntryItem]) {
        DispatchQueue.main.async {
            self.items.append(contentsOf: fetchedItems)
            self.itemsAreLoaded = true
        }
    }
    
    func addEntryCompletion(_ newItem: BudgetEntryItem) {
        DispatchQueue.main.async {
            self.items.append(newItem)
        }
    }
    
    func add(item: BudgetEntryItem) {
        addEntry(budgetEntry: item, completion: addEntryCompletion)
    }
 
    func remove(item: BudgetEntryItem, atOffsets: IndexSet) {
        func removeEntryCompletion() {
            DispatchQueue.main.async {
                self.items.remove(atOffsets: atOffsets)
            }
        }

        removeEntry(
            budgetEntry: item,
            completion: removeEntryCompletion
        )
    }
    
    func getSectionItems(type: String) -> [BudgetEntryItem] {
        return self.items.filter {
            $0.type == type
        }
    }
}
