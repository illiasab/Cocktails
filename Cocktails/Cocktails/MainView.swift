//
//  ContentView.swift
//  Cocktails
//
//  Created by Ylyas Abdywahytow on 10/14/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var fetch = CockatilFetch()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.basic.ignoresSafeArea(.all)
            VStack{
                
                List(fetch.filteredCocktails) { cocktail in
                    VStack(alignment: .leading) {
                        Text(cocktail.name)
                            .font(.headline)
                        
                        Text("Ingredients: \(cocktail.ingredients.joined(separator: ", "))")
                            .font(.subheadline)
                        Text("Instructions: \(cocktail.instructions)")
                            .font(.body)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            .onAppear {
                fetch.fetchCockTail(query: "")
                    
            }
            .searchable(text: $searchText, prompt: "Type cocktail name")
            .onChange(of: searchText) { newValue in
                fetch.searchCocktail(query: newValue)
                fetch.save()
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("I want to drink")
                        .padding(.top)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.button)
                }
        }
           
            }
        }
    }
}

#Preview {
    MainView()
}
