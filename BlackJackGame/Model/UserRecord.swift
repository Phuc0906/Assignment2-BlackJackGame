//
//  UserRecord.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 29/08/2023.
//

import Foundation

struct UserRecord {
    let id: Int
    let name: String
    var money: Int
    
    init(id: Int, name: String, money: Int) {
        self.id = id
        self.name = name
        self.money = money
    }
}
