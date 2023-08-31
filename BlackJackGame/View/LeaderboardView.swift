//
//  LeaderboardView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 29/08/2023.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var playerList: [UserRecord] = []
    @State private var playerName: String = ""
    @FocusState private var isFocused: Bool
    @State private var isAddPlayer: Bool = false
    @Binding var isShowLeaderboard: Bool
    @Binding var currnetPlayer: UserRecord?
    @State private var gameManager = GameManager()
    
    
    
    var body: some View {
        GeometryReader {geometry in
            NavigationView {
                ZStack {
                    VStack {
                        ForEach(playerList, id: \.id) {player in
                            LeaderboardPlayerView(playerId: player.id, playerName: player.name, playerMoney: player.money, isShowLeaderboard: $isShowLeaderboard, currentPlayer: $currnetPlayer)
                        }
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .navigationTitle("Top score")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Button(action: {
                                isShowLeaderboard = false
                            }) {
                                Text("Done")
                                    .font(.custom("CasinoFlatShadow-Regular", size: 24))
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                isAddPlayer = true
                            }) {
                                Text("Add player")
                                    .font(.custom("CasinoFlatShadow-Regular", size: 24))
                            }
                        }
                    }
                    .onAppear {
                        playerList = gameManager.getPlayers()
                    }.opacity(isAddPlayer ? 0 : 10)
                    
                    if (isAddPlayer) {
                        
                    }
                    
                    VStack(alignment: .center) {
                        Text("Enter player name")
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        VStack {
                            TextField("Player Name", text: $playerName)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .cornerRadius(20)
                                .border(isFocused ? Color.blue : Color.gray) // Highlighted border when focused
                                .focused($isFocused)
                                .font(.custom("CasinoFlatShadow-Regular", size: 24))
                            
                            Button(action: {
                                isAddPlayer = false
                                
                                if !playerName.isEmpty {
                                    print(playerName)
                                    var userMoney = gameManager.addPlayer(playerName: playerName)
                                    playerList.append(userMoney)
                                }
                                
                            }) {
                                Text("Add Player")
                                    .padding(EdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20))
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .font(.custom("CasinoFlatShadow-Regular", size: 24))
                            }
                                
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        
                        
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .opacity(isAddPlayer ? 1 : 0)
                    
                    
                }
            }
        }
    }
}

