//
//  BackgroundMusic.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 26/05/23.
//

import Foundation
import AVFoundation
import UIKit

var audioPlayer: AVAudioPlayer!

func playMusic(music: String) {
    guard let audioData = NSDataAsset(name: music)?.data else {
             fatalError("Unable to find asset \(music)")
          }

          do {
             audioPlayer = try AVAudioPlayer(data: audioData)
              audioPlayer.numberOfLoops = -1
              audioPlayer.play()
              print("music: \(music)")
          } catch {
             fatalError(error.localizedDescription)
        }
}

