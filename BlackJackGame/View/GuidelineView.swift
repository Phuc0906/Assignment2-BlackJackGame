//
//  GuidelineView.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 26/08/2023.
//

import SwiftUI

struct GuidelineView: View {
    @Binding var isPresent: Bool
    
    let gameFlow = [
        "Press Start Game button to start",
        "The system will distribute 2 card for you and 2 card for dealer",
        "You need to select bet amount before press start",
        "At the beginning, you will receive 20,000 $"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationView {
                    Form {
                        Section(header: Text("How to play")) {
                            List(gameFlow, id: \.self) {item in
                                Text(item)
                            }
                        }
                        
                        Section(header: Text("Game Interface")) {
                            Image("guide-1")
                                .resizable()
                                .frame(height: 700)
                            Image("guide-3")
                                .resizable()
                                .frame(height: 700)
                            Image("guide-5")
                                .resizable()
                                .frame(height: 700)

                        }
                        
                        Section(header: Text("Game rule")) {
                            Text("You are allowed to pick up to 5 cards")
                            Text("The score is compute according to card number except J, Q, K is 10 and the Ace card can be consider as 1 or 11")
                            Text("The system will compute dealer's and player's total score to find the winner")
                            Text("If your card is 10, J, Q, or K and the other is Ace, you will win directly (BlackJack)")
                            Text("If your score is less than or equal 21 and dealer's score is over 21, you will win and vice versa")
                            Text("If both score are less than or equal 21, the the greater is the winner")
                            Text("If 2 cards are Ace, you will win twice of your bet and vice versa")
                            Text("There are 3 levels: easy, medium, and hard")
                        }
                    }
                }
            }.navigationTitle("Game Instruction")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("Done")
                            .foregroundColor(.blue)
                            .font(.title3)
                            .onTapGesture {
                                isPresent = false
                            }
                    }
                }
        }
    }
}

//struct GuidelineView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuidelineView()
//    }
//}
