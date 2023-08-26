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
    @State private var numberOfCards = 0
    @State private var dealerCards = 0
    @State private var isGameStart = false
    @State private var isAllowPlayerPick = false
    @State private var isDealerCheckCard = false
    @State private var displayStatus = false
    @State private var playerWin = false
    @State private var isDraw = false
    @State private var isCoinDisplay = false
    @State private var is5kCoinDisplay = false
    @State private var is10kCoinDisplay = false
    @State private var coin1k = 0
    @State private var coin5k = 0
    @State private var coin10k = 0
    @State private var moneyRemaining = 25000
    @State private var isBetAlert = false
    @StateObject var gameManager = GameManager()
    
    
    // TODO: implement card array
    
    func checkBetSum() -> Int {
        return coin1k * 1000 + coin5k * 5000 + coin10k * 10000
    }
    
    func startGamePress() {
        if (checkBetSum() == 0) {
            isGameStart = false
            isBetAlert = true
            return
        }
        playSound(sound: "flip-sound", type: "mp3")
        yOffset = UIScreen.main.bounds.width / 2
        cardMoveAnimation = true
        // TODO: first card to player
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            cardMoveAnimation = false
            yOffset = 0
            numberOfCards += 1;
            // player receive card
            gameManager.playerPick()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // algorithm to decide if dealer continue to pick
                playSound(sound: "flip-sound", type: "mp3")
                yOffset = -UIScreen.main.bounds.width / 2
                cardMoveAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cardMoveAnimation = false
                    yOffset = 0
                    // TODO: first card to dealer
                    dealerCards += 1;
                    gameManager.dealerPick()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1)  {
                        playSound(sound: "flip-sound", type: "mp3")
                        yOffset = UIScreen.main.bounds.width / 2
                        cardMoveAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            cardMoveAnimation = false
                            yOffset = 0
                            numberOfCards += 1;
                            // player receive card
                            // TODO: second card to player
                            gameManager.playerPick()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                // algorithm to decide if dealer continue to pick
                                playSound(sound: "flip-sound", type: "mp3")
                                yOffset = -UIScreen.main.bounds.width / 2
                                cardMoveAnimation = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    cardMoveAnimation = false
                                    yOffset = 0
                                    dealerCards += 1;
                                    // TODO: second card to dealer
                                    gameManager.dealerPick()
                                    isAllowPlayerPick = true
                                    
                                }
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
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
                            ForEach(0..<gameManager.dealerCards.count, id: \.self) {index in
                                // TODO: get cards array here
                                // TODO: store picked card into dealer cards array
                                // the image name will pop from card array
                                if (index < 1) {
                                    Image(gameManager.dealerCards[index])
                                        .resizable()
                                        .frame(width: 75, height: 110)
                                        .animation(.easeOut(duration: 1))
                                }else {
                                    Image(!isDealerCheckCard ? "blue_back" : gameManager.dealerCards[index])
                                        .resizable()
                                        .frame(width: 75, height: 110)
                                        .animation(.easeOut(duration: 1))
                                }
                                
                            }
                        }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(minHeight: 110)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "gear.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Spacer()
                        ZStack {
                            Image("blue_back")
                                .resizable()
                                .frame(width: 55, height: 75)
                                .foregroundColor(.white)
                            Image("blue_back")
                                .resizable()
                                .frame(width: 55, height: 75)
                                .foregroundColor(.white)
                                .offset(y: yOffset)
                                .animation(cardMoveAnimation ? .easeIn(duration: 1) : nil)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer()
                    VStack {
                        ZStack {
                            VStack {
                                HStack {
                                    ZStack {
                                        Image("2k-chip")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        // quantity of chip
                                        Text("\(coin1k)")
                                    }.onTapGesture {
                                        coin1k -= 1
                                    }
                                    ZStack {
                                        Image("5k-chip")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        // quantity of chip
                                        Text("\(coin5k)")
                                    }.onTapGesture {
                                        coin5k -= 1
                                    }
                                    ZStack {
                                        Image("10k-chip")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        // quantity of chip
                                        Text("\(coin10k)")
                                    }.onTapGesture {
                                        coin10k -= 1
                                    }
                                    
                                }
                                HStack(spacing: 0) {
                                    
                                    ForEach(0..<gameManager.playerCards.count, id: \.self) {index in
                                        
                                        // TODO: get cards array here
                                        // TODO: store picked card into player cards array
                                        // the image name will pop from card array
                                        Image(gameManager.playerCards[index])
                                            .resizable()
                                            .frame(width: 75, height: 110)
                                            .rotation3DEffect(
                                                Angle(degrees: 0),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.easeOut(duration: 1))
                                    }
                                
                                    
                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    .frame(minHeight: 110)
                            }
                            
                            if (!isGameStart) {
                                HStack {
                                    Button("Start Game") {
                                        isGameStart = true
                                        startGamePress()
                                    }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                                    .foregroundColor(.white)
                                    .background(.red)
                                    .cornerRadius(20)
                                }.padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 20))
                            }else if (isAllowPlayerPick) {
                                OptionButtonView(gameManager: gameManager, yOffset: $yOffset, cardMoveAnimation: $cardMoveAnimation, isAllowPlayerPick: $isAllowPlayerPick, isDealerCheckCard: $isDealerCheckCard, isDisplayStatus: $displayStatus, isPlayerWin: $playerWin, isDraw: $isDraw,
                                moneyRemaining: $moneyRemaining,
                                chip1k: $coin1k,
                                chip5k: $coin5k,
                                chip10k: $coin10k)
                            }else if (isDealerCheckCard) {
                                HStack {
                                    Button("Play again") {
                                        // MARK: reset game state
                                        isGameStart = false
                                        isDealerCheckCard = false
                                        displayStatus = false
                                        playerWin = false
                                        isDraw = false
                                        gameManager.restartGame()
                                    }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                                    .foregroundColor(.white)
                                    .background(.red)
                                    .cornerRadius(20)
                                }.padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 20))
                            }
                        }.frame(minHeight: 110)
                        
                        // TODO: dislay player's budget
                        ZStack {
                            HStack {
                                HStack {
                                   Image("coin")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 30)
                                    Text("\(moneyRemaining) $")
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                ZStack {
                                   Image("")
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
                
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        VStack {
                            ZStack {
                                Image("2k-chip")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    
                                Text("1k")
                            }.opacity(isCoinDisplay ? 10 : 0)
                                .transition(.opacity)
                                .onTapGesture {
                                    coin1k += 1
                                }
                                
                            ZStack {
                                Image("5k-chip")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    
                                Text("5k")
                            }.opacity(is5kCoinDisplay ? 10 : 0)
                                .transition(.opacity)
                                .onTapGesture {
                                    coin5k += 1
                                }
                            
                            
                            
                            ZStack {
                                Image("10k-chip")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    
                                Text("10k")
                            }.opacity(is10kCoinDisplay ? 10 : 0)
                                .transition(.opacity)
                                .onTapGesture {
                                    coin10k += 1
                                }
                        }
                        
                        Image("coin")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 60, height: 30)
                             .onTapGesture {
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                     
                                     is10kCoinDisplay.toggle()
                                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                         is5kCoinDisplay.toggle()
                                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                             isCoinDisplay.toggle()
                                         }
                                     }
                                 }
                             }
                    }
                }
                    
            }
            
            if (displayStatus) {
                if (!isDraw) {
                    if (playerWin) {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image("you-win")
                                    .resizable()
                                    .frame(width: geometry.size.width/2, height: geometry.size.height/3)
                                Spacer()
                            }
                            Spacer()
                        }
                    }else {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image("you-lose")
                                    .resizable()
                                    .frame(width: geometry.size.width/2, height: geometry.size.height/3)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.onAppear {
//            playSound(sound: "shuffle-sound", type: "mp3")
            // TODO: suffle card array
            // code for suffle card
            print("before shuffle: \(gameManager.cards[0])")
            gameManager.shuffleCards()
            print("After shuffle: \(gameManager.cards[0])")
        }.alert(isPresented: $isBetAlert) {
            Alert(title: Text("You are not set the bet yet"))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
