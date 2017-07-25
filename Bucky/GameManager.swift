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
    func gameManagerDidGameStart(_ gameManager: GameManager, fallingObject: FallingObject)
    func gameManagerDidSpawnNewFallingObject(_ gameManager: GameManager, fallingObject: FallingObject)
    func gameManagerDidUpdateScore(_ gameManager: GameManager, newScore: Int)
    func gameManagerDidUpdateLives(_ gameManager: GameManager, leftLives: Int)
    func gameManagerRemoveFromSuperView(_ gameManager: GameManager, ball: BallView)
    func gameManagerDidUpdateHighScore(_ gameManager: GameManager, highScore: Int)
    func gameManagerDidEncounterGameOver(_ gameManager: GameManager)    
}

class GameManager  {
    
    var currentScore:Int = 0
    var leftLives :Int = 3
    var highestScore: Int = 0
    var delegate: GameManagerProtocol?
    
    init(currentScore: Int, leftLives: Int){
        self.currentScore = currentScore
        self.leftLives = leftLives
        self.highestScore = UserDefaults.standard.integer(forKey: "highestScore")
    }
    
    init() { }
    
    func gameStartOrReset() {
        GameManager(currentScore: 0, leftLives: 3)
        
        var velocity = arc4random_uniform(6) + 5
        let fallingObject  = FallingObject(objectType: FallingObjectType[Int(arc4random_uniform(3)].rawValue, velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400) , y: 0, width: 20, height: 20))
            delegate?.gameManagerDidGameStart(self, fallingObject: fallingObject)
            
            repeatBalls()
    }
    
    @objc func spawnNewFallingObject() {
        
        var velocity = arc4random_uniform(6) + 5
        let fallingObject  = FallingObject(objectType: FallingObjectType[Int(arc4random_uniform(3)].rawValue, velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400) , y: 0, width: 20, height: 20))
            delegate?.gameManagerDidSpawnNewFallingObject(self, fallingObject: fallingObject)
    }
    
    func repeatBalls() {
        var timer = Timer()
        let delay = 0.5
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(spawnNewFallingObject), userInfo: nil, repeats: true)
    }
    
    func checkBallIsFoulOrCatch(bucket: UIView, ball : FallingObject) {
        if bucket.frame.intersects(ball.frame) {
            currentScore += ball.type.score
            
            delegate?.gameManagerDidUpdateScore(self, newScore: currentScore)
            delegate?.gameManagerRemoveFromSuperView(self, ball: ball)
        }else {
            leftLives -= 1
            delegate?.gameManagerDidUpdateLives(self, leftLives: leftLives)
            delegate?.gameManagerRemoveFromSuperView(self, ball: ball)
        }
        if currentScore > highestScore {
            highestScore = currentScore
            delegate?.gameManagerDidUpdateHighScore(self, highScore: highestScore)
        }
        if leftLives == 0 {
            delegate?.gameManagerDidEncounterGameOver(self)
        }
    }
}
