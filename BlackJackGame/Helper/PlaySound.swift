//
//  PlaySound.swift
//  BlackJackGame
//
//  Created by Phuc Hoang on 24/08/2023.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Error in playing sound")
        }
    }
}
