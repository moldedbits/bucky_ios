//
//  GameManager.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit

protocol GameManagerProtocol {
    func gameManager(_ gameManager: GameManager, didGameStart fallingObject: FallingObject)
    func gameManager(_ gameManager: GameManager, didSpawnNewFallingObject fallingObject: FallingObject)
    func gameManager(_ gameManager: GameManager, didUpdateCurrentScore newScore: Int)
    func gameManager(_ gameManager: GameManager, didUpdateLives lives: Int)
    func gameManager(_ gameManager: GameManager, didRemoveFromSuperView ball: FallingObject)
    func gameManager(_ gameManager: GameManager, didUpdateHighScore highScore: Int)
    func gameManagerDidEncounterGameOver(_ gameManager: GameManager)
}

class GameManager {
    
    var timer = Timer()
    var currentScore:Int = 0
    var leftLives :Int = 3
    var highestScore: Int = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
    var delegate: GameManagerProtocol?
    var isGameOver = false
    
    func gameStart() {
        currentScore = 0
        leftLives = 3
        highestScore = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
        let velocity = 2.0
        let fallingObject = FallingObject( objectType: FallingObject().random()
            ?? FallingObjectType.ballGreen, velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400)) , y: 0, width: 20, height: 20))
        delegate?.gameManager(self, didGameStart: fallingObject)
        
        repeatFallingObjects()
    }
    
    func repeatFallingObjects() {
        let delay = 2.0
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(spawnNewFallingObject), userInfo: nil, repeats: true)
    }
    
    @objc func spawnNewFallingObject() {
        let velocity = 2.0
        let fallingObject  = FallingObject(objectType: FallingObject().random()
            ?? FallingObjectType.ballGreen, velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400)) , y: 0, width: 20, height: 20))
        delegate?.gameManager(self, didSpawnNewFallingObject: fallingObject)
    }
    
    func checkBallIsFoulOrCatch(bucket: UIImageView, ball: FallingObject) {
        let range = Int(bucket.frame.width/2) - 10
        let midXOfBucket = Int(bucket.frame.midX)
        let midXOfFallingObject = Int(ball.frame.midX)
        if midXOfFallingObject - range <= midXOfBucket && midXOfBucket <= midXOfFallingObject + range {
            currentScore += ball.type.score
            delegate?.gameManager(self, didUpdateCurrentScore: currentScore)
            delegate?.gameManager(self, didRemoveFromSuperView: ball)
        } else {
            leftLives -= 1
            delegate?.gameManager(self, didUpdateLives: leftLives)
            delegate?.gameManager(self, didRemoveFromSuperView: ball)
        }
        if currentScore > highestScore {
            highestScore = currentScore
            UserDefaults.standard.set(highestScore, forKey: UserDefaultsKey.highestScore)
            delegate?.gameManager(self, didUpdateHighScore: highestScore)
        }
        if leftLives <= 0 {
            timer.invalidate()
            if !isGameOver {
                UserDefaults.standard.set(currentScore, forKey: UserDefaultsKey.currentScore)
                delegate?.gameManagerDidEncounterGameOver(self)
            }
            isGameOver = true
        }
    }
}
