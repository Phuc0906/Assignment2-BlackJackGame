//
//  ContentView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToNextView = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("welcome-background")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Image("game-logo")
                        .resizable()
                        .scaledToFit()
                        .padding(40)
                    Text("Welcome to COSC2659 Black Jack Game")
                        .foregroundColor(.white)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button("Start Game") {
                        navigateToNextView = true
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .foregroundColor(.white)
                    .background(Color(UIColor(red: 0.01, green: 0.41, blue: 0.16, alpha: 1.00)))
                    .cornerRadius(20)
                    
                    Spacer()
                    
                }
            }
        }.fullScreenCover(isPresented: $navigateToNextView) {
            GameView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
