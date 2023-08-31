//
//  OptionButtonView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 19/08/2023.
//

import CoreML
import SwiftUI

struct OptionButtonView: View {
    @StateObject var gameManager: GameManager
    @Binding var yOffset: CGFloat
    @Binding var cardMoveAnimation: Bool
    @Binding var isAllowPlayerPick: Bool
    @Binding var isDealerCheckCard: Bool
    @Binding var isDisplayStatus: Bool
    @Binding var isPlayerWin: Bool
    @Binding var isDraw: Bool
    @Binding var moneyRemaining: Int
    @Binding var chip1k: Int
    @Binding var chip5k: Int
    @Binding var chip10k: Int
    @Binding var dataArray: [(Int, String, Int)]
    @Binding var currentPlayer: UserRecord?
    @Binding var isHard: Bool
    
    func dealerProcess(onDealerDone: @escaping () -> Void){
        var totalScore = gameManager.getDealerScore()
        if (totalScore == 22) {
            totalScore = 31
        }
        
        if (totalScore > 21 && totalScore != 31 && gameManager.isContainA(cardsList: gameManager.dealerCards)) {
            for i in 0..<gameManager.dealerCards.count {
                if (gameManager.dealerCards[i].contains("A")) {
                    totalScore -= 10
                    break
                }
            }
        }
        
        if totalScore <= 16 {
            //apply machine learning here
            do {
                if isHard { // pick with Machine Learning
                    
                    let config = MLModelConfiguration()
                    let model = try BlackJackClassificationModel(configuration: config)
                    let prediction = try model.prediction(number_of_card: Double(gameManager.dealerCards.count), total_point: Double(totalScore), pick: "True")
                    print(prediction.win)
                    if (prediction.win == "True") {
                        playSound(sound: "flip-sound", type: "mp3")
                        yOffset = -UIScreen.main.bounds.width / 2
                        cardMoveAnimation = true
                        // TODO: first card to player
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            cardMoveAnimation = false
                            yOffset = 0
                            // player receive card
                            gameManager.dealerPick()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                dealerProcess(onDealerDone: onDealerDone)
                            }
                        }
                    }else { // pick randomly
                        isAllowPlayerPick = false
                        isDealerCheckCard = true
                        print("Dealer score computed 1: \(totalScore)")
                        print(gameManager.dealerCards)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            onDealerDone()
                        }
                    }
                }else {
                    playSound(sound: "flip-sound", type: "mp3")
                    yOffset = -UIScreen.main.bounds.width / 2
                    cardMoveAnimation = true
                    // TODO: first card to player
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        cardMoveAnimation = false
                        yOffset = 0
                        // player receive card
                        gameManager.dealerPick()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            dealerProcess(onDealerDone: onDealerDone)
                        }
                    }
                }
            }catch {
                print("err")
            }
            
        }else {
             
            isAllowPlayerPick = false
            isDealerCheckCard = true
            print("Dealer score computed 2: \(totalScore)")
            print(gameManager.dealerCards)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onDealerDone()
            }
        }
        gameManager.dealerTotalScore = totalScore
        
        
    }
    
    func gameDecision() {
        let playerBet = chip1k * 1000 + chip5k * 5000 + chip10k * 10000
        let playerScore = gameManager.getPlayerScore()
        let dealerScore = gameManager.dealerTotalScore
        print("Dealer score: \(dealerScore) - Player score: \(playerScore)")
        if (playerScore == dealerScore) {
            print("Draw")
            isDraw = true
        }else if (dealerScore == 31) {
            print("Dealer win twice")
            moneyRemaining -= playerBet * 2
        }else if (playerScore == 31) {
            isPlayerWin = true
            print("Player win twice")
            moneyRemaining += playerBet * 2
        }else if ((playerScore == 21) && (gameManager.playerCards.count == 2)) {
            isPlayerWin = true
            print("Player got black jack")
            moneyRemaining += playerBet
        }else if ((dealerScore == 21) && (gameManager.dealerCards.count == 2)) {
            print("Dealer got black jack")
            moneyRemaining -= playerBet
        }else if ((playerScore > dealerScore) && (playerScore <= 21)) {
            print("Player win")
            isPlayerWin = true
            moneyRemaining += playerBet
        }else if ((dealerScore > playerScore) && (dealerScore <= 21)) {
            print("Dealer win")
            moneyRemaining -= playerBet
        }else {
            if (playerScore > 21) {
                print("Dealer win")
                moneyRemaining -= playerBet
            }else if (dealerScore > 21) {
                isPlayerWin = true
                print("Player win")
                moneyRemaining += playerBet
            }else {
                isDraw = true
                print("Draw")
            }
        }
        
        if (!isDraw) {
            if (isPlayerWin) {
                playSound(sound: "win-sound", type: "mp3")
            }else {
                playSound(sound: "lose-sound", type: "mp3")
            }
        }
        
        isDisplayStatus = true
        chip1k = 0
        chip5k = 0
        chip10k = 0
        gameManager.updatePlayer(playerId: currentPlayer?.id ?? -1, money: moneyRemaining)
        
    }
    
    
    var body: some View {
        HStack(spacing: 50) {
            Button("Pass") {
                isAllowPlayerPick = false
                
                // ------
                
                dealerProcess {
                    gameDecision()
                }
                
                //-----
            }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(20)
            .font(.custom("CasinoFlatShadow-Regular", size: 17))
            Button("Pick") {
                playSound(sound: "flip-sound", type: "mp3")
                yOffset = UIScreen.main.bounds.width / 2
                cardMoveAnimation = true
                // TODO: first card to player
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cardMoveAnimation = false
                    yOffset = 0
                    // player receive card
                    gameManager.playerPick()
                }
            }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(20)
            .font(.custom("CasinoFlatShadow-Regular", size: 17))
        }.padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 20))
    }
}

