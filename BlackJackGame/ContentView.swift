//
//  ContentView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToNextView = false
    @State private var isShowGuideline = false
    @State private var isShowLeaderboard = false
    @State private var userDefault = UserDefaults.standard
    @State private var isSelectPlayer = false
    @State private var currentPlayer: UserRecord? = nil
    @State private var isHard = false
    @State private var isDisplayLevelSelection = false
    var body: some View {
        
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Image("welcome-background")
                        .resizable()
                        .ignoresSafeArea()
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Image("game-logo")
                            .resizable()
                            .scaledToFit()
                            .padding(40)
                        Text("Welcome to COSC2659 Black Jack Game")
                            .foregroundColor(.white)
                            .font(.custom("CasinoFlatShadow-Regular", size: 34))
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button("Start Game") {
                            if let player = currentPlayer {
                                navigateToNextView = true
                            }else {
                                isSelectPlayer = true
                            }
                            
                            
                        }
                        .font(.custom("CasinoFlatShadow-Regular", size: 24))
                        .padding(EdgeInsets(top: 15, leading: 30, bottom: 30, trailing: 30))
                        .foregroundColor(.white)
                        .background(
                            Image("button_bg") // Replace "yourImageName" with the actual name of your image asset
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .clipped()
                        )
                        .cornerRadius(20)
                        
                        if let user = currentPlayer {
                            Text("Welcome \(user.name)")
                                .foregroundColor(.white)
                                .font(.custom("CasinoFlatShadow-Regular", size: 22))
                        }
                        
                        Spacer()
                        HStack {
                            Image(systemName: "gamecontroller")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    isShowLeaderboard = true
                                }
                            Spacer()
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    isShowGuideline = true
                                }
                            Spacer()
                            Image(systemName: "gear.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    isDisplayLevelSelection = true
                                }
                                
                        }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                    }
                    
                    VStack(alignment: .center) {
                        Text("Please Select Mode")
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                            .font(.custom("CasinoFlatShadow-Regular", size: 26))
                        VStack {
                            
                            
                            Button(action: {
                                isDisplayLevelSelection = false
                                isHard = false
                            }) {
                                Text("Easy")
                                    .padding(EdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20))
                                    .background(.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .font(.custom("CasinoFlatShadow-Regular", size: 17))
                            }
                            
                            Button(action: {
                                isHard = true
                                isDisplayLevelSelection = false
                            }) {
                                Text("Hard")
                                    .padding(EdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20))
                                    .background(.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .font(.custom("CasinoFlatShadow-Regular", size: 17))
                            }
                                
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        
                        
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .opacity(isDisplayLevelSelection ? 1 : 0)
                    
                }.alert(isPresented: $isSelectPlayer) {
                    Alert(title: Text("Please select player in leaderboard"))
                }
            }.fullScreenCover(isPresented: $navigateToNextView) {
                GameView(currentPlayer: $currentPlayer, isHard: $isHard)
            }.sheet(isPresented: $isShowGuideline) {
                GuidelineView(isPresent: $isShowGuideline)
            }.sheet(isPresented: $isShowLeaderboard) {
                LeaderboardView(isShowLeaderboard: $isShowLeaderboard, currnetPlayer: $currentPlayer)
            }
        }
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
