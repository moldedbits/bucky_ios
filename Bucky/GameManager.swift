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
    
    var currentScore:Int = 0
    var leftLives :Int = 3
    var highestScore: Int = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
    var delegate: GameManagerProtocol?
    
    init(currentScore: Int, leftLives: Int){
        self.currentScore = currentScore
        self.leftLives = leftLives
        self.highestScore = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
    }
    
    init() { }
    
    func createFallingObjectType()-> FallingObjectType {
        var fallingObjectType: FallingObjectType
        guard fallingObjectType = FallingObjectType.random() else {
            fallingObjectType = FallingObjectType.ballGreen
        }
        
        return fallingObjectType
    }
    
    func gameStart() {
        highestScore = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
        let velocity = Double(arc4random_uniform(6) + 5 )
        let fallingObject = FallingObject( objectType: createFallingObjectType(), velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400)) , y: 0, width: 20, height: 20))
        delegate?.gameManager(self, didGameStart: fallingObject)
        
        repeatFallingObjects()
    }
    
    func repeatFallingObjects() {
        var timer = Timer()
        let delay = 0.5
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(spawnNewFallingObject), userInfo: nil, repeats: true)
    }
    
    func gameReset() {
        currentScore = 0
        leftLives = 3
        gameStart()
    }
    
    @objc func spawnNewFallingObject() {
        let velocity = Double(arc4random_uniform(6) + 5)
        let fallingObject  = FallingObject(objectType: createFallingObjectType(), velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400)) , y: 0, width: 20, height: 20))
        delegate?.gameManager(self, didSpawnNewFallingObject: fallingObject)
    }
    
    func checkBallIsFoulOrCatch(bucket: UIView, ball : FallingObject) {
        let midXOfBucket = Int(bucket.frame.midX)
        let midXOfFallingObject = Int(ball.frame.midX)
        if midXOfFallingObject - 10 <= midXOfBucket && midXOfBucket <= midXOfFallingObject + 10 {
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
            delegate?.gameManagerDidEncounterGameOver(self)
        }
    }
}
