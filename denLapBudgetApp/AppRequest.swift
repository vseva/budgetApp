//
//  AppRequest.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 13.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


class AppRequest {
    static func getEntries(completion: @escaping ([BudgetEntryItem]) -> Void) {
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

    static func addEntry(budgetEntry: BudgetEntryItem, completion: @escaping (BudgetEntryItem) -> Void) {
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

    static func updateEntry(budgetEntry: BudgetEntryItem, completion: @escaping (BudgetEntryItem) -> Void) {
        var request = prepareRequest(location: AppConstants.apiUpdateEntry)
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
                    if let updatedEntry = json["updated"] as? [String: Any] {
                        let updatedBudgetEntry = try BudgetEntryItem(json: updatedEntry)
                        completion(updatedBudgetEntry)
                    } else {
                        print("cant update elem from updated response")
                    }
                }
            } catch let error as NSError {
                print("JSON error: \(error.localizedDescription)")
            }
        }.resume()
    }

    static func removeEntry(
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
                        print("Entry deleted", deletedEntryId)
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
}
