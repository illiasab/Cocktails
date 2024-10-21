//
//  StartScreen.swift
//  Quotes
//
//  Created by Ylyas Abdywahytow on 10/18/24.
//
import SwiftUI
import Foundation
struct StartScreen: View {
    @State var pressed: Bool = false
    @State var show: Bool = false
    @ObservedObject var fetch = CockatilFetch()
    @State var searchText: String = ""
    var Juice: String = "juice"
    var Drink: String = "Drink"
    var buttonText: String = "Get Started >"
    var script: String = "FREESCPT"
    var mainImage: String = "cocktail"
    var newFont: String = "Poppins-SemiBold"
    var title: String = "It’s time for a"
    
    var body: some View {
            NavigationStack {
                ZStack {
                    
                    Color.basic.ignoresSafeArea()
                    
                    VStack {
                   
                        Spacer().padding(.top, 150)
                        Image(Juice)
                    }
                    
                    VStack {
                        
                        Spacer().padding(.top, 10)
                        Text(Drink)
                            .foregroundColor(.script)
                            .font(.custom(script, size: 60))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing,215)
                        
                       
                        Button(action: {
                            pressed.toggle()
                            if pressed {
                                show = true
                            }
                        }) {
                            Text(buttonText)
                                .frame(width: 180, height: 58)
                                .foregroundColor(.white)
                                .background(Color.button)
                                .cornerRadius(40)
                                .font(.system(size: 20))
                                .padding(.trailing, 180)
                        }
                        .navigationDestination(isPresented: $show) {
                            MainView()
                        }
              
                        Spacer()
                        Image(mainImage)
                            .resizable()
                            .frame(width: 302, height: 532)
                    }
                    .navigationTitle(title)
                    .font(.custom(newFont, size: 40))
                    .padding(.horizontal, 100)
                }
            }
        }
    }

    #Preview {
        StartScreen()
    }
