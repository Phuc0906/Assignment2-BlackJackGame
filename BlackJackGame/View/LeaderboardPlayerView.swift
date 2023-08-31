//
//  LeaderboardPlayerView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 29/08/2023.
//

import SwiftUI

struct LeaderboardPlayerView: View {
    @State var playerId: Int = -1
    @State var playerName: String = "Phuc Hoang 2"
    @State var playerMoney: Int = 20000
    @Binding var isShowLeaderboard: Bool
    @Binding var currentPlayer: UserRecord?
    
    var body: some View {
        HStack {
            HStack {
                Image("king")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(playerName)
                    .font(.custom("CasinoFlatShadow-Regular", size: 20))
            }
            Spacer()
            Text("\(playerMoney) $")
                .font(.custom("CasinoFlatShadow-Regular", size: 20))
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(Color.white) // Set the background color
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .onTapGesture {
            isShowLeaderboard = false
            print("Tap \(playerName)")
            currentPlayer = UserRecord(id: playerId, name: playerName, money: playerMoney)
        }
        
    }
}

