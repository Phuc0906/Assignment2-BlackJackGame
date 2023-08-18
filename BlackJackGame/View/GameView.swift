//
//  GameView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 11/08/2023.
//

import SwiftUI

struct GameView: View {
    @State private var yOffset: CGFloat = 0
    @State private var cardMoveAnimation = false
    @State private var numberOfCards = 2
    @State private var dealerCards = 2
    // TODO: implement card array
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Image("casino-table")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Text("Dealer")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        HStack(spacing: 0) {
                            ForEach(0..<dealerCards, id: \.self) {index in
                                // TODO: get cards array here
                                // TODO: store picked card into dealer cards array
                                // the image name will pop from card array
                                if (index < 1) {
                                    Image("2D")
                                        .resizable()
                                        .frame(width: 75, height: 110)
                                        .animation(.easeOut(duration: 1))
                                }else {
                                    Image("blue_back")
                                        .resizable()
                                        .frame(width: 75, height: 110)
                                        .animation(.easeOut(duration: 1))
                                }
                                
                                
                                
                            }
                        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "gear.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Spacer()
                        Image("blue_back")
                            .resizable()
                            .frame(width: 55, height: 75)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
                    VStack {
                        ZStack {
                            HStack(spacing: 0) {
                                
                                ForEach(0..<numberOfCards, id: \.self) {index in
                                    
                                    // TODO: get cards array here
                                    // TODO: store picked card into player cards array
                                    // the image name will pop from card array
                                    Image("2D")
                                        .resizable()
                                        .frame(width: 75, height: 110)
                                        .rotation3DEffect(
                                            Angle(degrees: 0),
                                            axis: (x: 0, y: 1, z: 0)
                                        )
                                        .animation(.easeOut(duration: 1))
                                }
                                
                                
                                
                                
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            HStack(spacing: 50) {
                                Button("Pass") {
                                    
                                }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                                .foregroundColor(.white)
                                .background(.red)
                                .cornerRadius(20)
                                Button("Pick") {
                                    if (numberOfCards < 5) {
                                        yOffset = UIScreen.main.bounds.width / 2
                                        cardMoveAnimation = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            cardMoveAnimation = false
                                            yOffset = 0
                                            numberOfCards += 1;
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                // algorithm to decide if dealer continue to pick
                                                
                                                yOffset = -UIScreen.main.bounds.width / 2
                                                cardMoveAnimation = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    cardMoveAnimation = false
                                                    yOffset = 0
                                                    dealerCards += 1;
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                            }
                        }
                        ZStack {
                            HStack {
                                HStack {
                                   Image("coin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 30)
                                    Text("3000$")
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                HStack {
                                   Image("coin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 30)
                                    
                                }
                            }
                            HStack {
                                Text("Player")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                        }
                    }
                }
                VStack {
                    Image("blue_back")
                        .resizable()
                        .frame(width: 55, height: 75)
                        .foregroundColor(.white)
                        .offset(y: yOffset)
                        .animation(cardMoveAnimation ? .easeIn(duration: 1) : nil)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                        
                }
            }
        }.onAppear {
            // TODO: suffle card array
            // code for suffle card
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
