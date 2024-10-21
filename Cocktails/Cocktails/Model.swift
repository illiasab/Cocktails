//
//  Model.swift
//  Cocktails
//
//  Created by Ylyas Abdywahytow on 10/14/24.
//
import Foundation
import SwiftUI

struct Cocktail: Decodable, Identifiable, Encodable {
    let id = UUID() 
    let ingredients: [String]
    let instructions: String
    let name: String
}

class CockatilFetch: ObservableObject {
    @Published var fetches = [Cocktail]()
    @Published var filteredCocktails = [Cocktail]()
    @Published var Juice: String = "juice"
    @Published var Drink: String = "Drink"
    @Published var buttonText: String = "Get Started >"

    init (){
      if let data = UserDefaults.standard.data(forKey: "SavedData") {
                  if let decoded = try? JSONDecoder().decode([Cocktail].self, from: data) {
                      fetches = decoded
                      filteredCocktails = decoded
                      return 
                  }
              }
        fetchCockTail(query: "")
    }

    func fetchCockTail(query: String) {
        let urlString = "https://api.api-ninjas.com/v1/cocktail?name=\(query)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("8b3E2HX1w13LRoqNqn456Q==6sVOGIuMVlf92HEk", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                DispatchQueue.main.async {
                    self.fetches = cocktails
                    self.filteredCocktails = query.isEmpty ? cocktails : cocktails.filter {
                        $0.name.lowercased().contains(query.lowercased())
                    }
                }
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
    func searchCocktail(query: String) {
        fetchCockTail(query: query)
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(fetches) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
}

//extension View {
//    @available(iOS 14, *)
//    func navigationBarTitleTextColor(_ color: Color) -> some View {
//        let uiColor = UIColor(color)
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
//        return self
//    }
//}
