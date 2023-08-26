//
//  GameManager.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 19/08/2023.
//

import Foundation

class GameManager: ObservableObject {
    @Published var cards: [String] = []
    @Published var dealerCards: [String] = []
    @Published var playerCards: [String] = []
    @Published var dealerTotalScore: Int = 0
    private var cardPick = 0
    
    init() {
        let numberCard: [String] = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        let cardTypes: [String] = ["S", "H", "D", "C"]
        var cardInit: [String] = []
        for card in numberCard {
            for cardType in cardTypes {
                cardInit.append(card + cardType)
            }
        }
        self.cards = cardInit
    }
    
    func playerPick() {
        playerCards.append(cards[cardPick])
        cardPick += 1
    }
    
    func dealerPick() {
        print("Pick here")
        dealerCards.append(cards[cardPick])
        cardPick += 1
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
    
    private func scoreConverter(score: String) -> Int {
        switch score.first {
        case "A":
            return 11
        case "K", "Q", "J":
            return 10
        default:
            if (score.contains("10")) {
                return 10
            }else {
                if let firstChar = score.first, let intValue = Int(String(firstChar)) {
                    return intValue
                }else {
                    return 0
                }
            }
        }
    }
    
    func isContainA(cardsList: [String]) -> Bool {
        for playingCard in cardsList {
            if (playingCard.contains("A")) {
                return true
            }
        }
        
        
        return false
    }
    
    func getPlayerScore() -> Int {
        var playerScore = 0
        for playerCard in playerCards {
            playerScore += scoreConverter(score: playerCard)
        }
        
        print(playerCards)
        print("Is contain A: \(isContainA(cardsList: playerCards))")
        if (playerScore > 21) && (isContainA(cardsList: playerCards)) {
            print("IN this")
            // recompute player score
            playerScore = 0
            var isCheckA: Bool = false
            for i in 0..<playerCards.count {
                if (playerCards[i].contains("A") && !isCheckA) {
                    isCheckA = true
                    playerScore += 1
                }else {
                    playerScore += scoreConverter(score: playerCards[i])
                }
                
            }
        }
        
        
        if (playerCards[0].contains("A") && playerCards[1].contains("A") && playerCards.count == 2) {
            playerScore = 31
        }
        
        
        return playerScore
    }
    
    func getDealerScore() -> Int {
        var dealerScore = 0
        for dealerCard in dealerCards {
            dealerScore += scoreConverter(score: dealerCard)
        }
        return dealerScore
    }
    
    // MARK: game restart
    func restartGame() {
        cardPick = 0
        shuffleCards()
        dealerCards = []
        playerCards = []
    }
    
    func isRecomputeDealer() -> Bool {
        if (isContainA(cardsList: dealerCards)) {
            for var dealer_card in dealerCards {
                if (dealer_card.contains("A")) {
                    dealer_card = "1H"
                    break
                }
            }
            return true
        }else {
            return false
        }
    }

}
