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
    func gameManager(_ gameManager: GameManager,DidGameStart fallingObject: FallingObject)
    func gameManager(_ gameManager: GameManager, DidSpawnNewFallingObject fallingObject: FallingObject)
    func gameManager(_ gameManager: GameManager, DidUpdateCurrentScore NewScore: Int)
    func gameManager(_ gameManager: GameManager, DidUpdateLives Lives: Int)
    func gameManager(_ gameManager: GameManager, RemoveFromSuperView ball: FallingObject)
    func gameManager(_ gameManager: GameManager, DidUpdateHighScore HighScore: Int)
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
        self.highestScore = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
    }
    
    init() { }
    
    func gameStartOrReset() {
        GameManager(currentScore: 0, leftLives: 3)
        let index = 0
        var velocity = Double(arc4random_uniform(6) + 5 )
        let fallingObject = FallingObject( objectType: FallingObjectType.ballBlue, velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400)) , y: 0, width: 20, height: 20))
        delegate?.gameManager(self, DidGameStart: fallingObject)
        
        repeatFallingObjects()
    }
    
    @objc func spawnNewFallingObject() {
        var velocity = Double(arc4random_uniform(6) + 5)
        let fallingObject  = FallingObject(objectType: FallingObjectType.ballBlue, velocity: velocity, frame: CGRect(x: Int(arc4random_uniform(400)) , y: 0, width: 20, height: 20))
        delegate?.gameManager(self, DidSpawnNewFallingObject: fallingObject)
        
    }
    
    func repeatFallingObjects() {
        var timer = Timer()
        let delay = 0.5
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(spawnNewFallingObject), userInfo: nil, repeats: true)
    }
    
    func checkBallIsFoulOrCatch(bucket: UIView, ball : FallingObject) {
        if bucket.frame.intersects(ball.frame) {
            currentScore += ball.type.score
            
            delegate?.gameManager(self, DidUpdateCurrentScore: currentScore)
            delegate?.gameManager(self, RemoveFromSuperView: ball)
        }else {
            leftLives -= 1
            delegate?.gameManager(self, DidUpdateLives: leftLives)
            delegate?.gameManager(self, RemoveFromSuperView: ball)
        }
        if currentScore > highestScore {
            highestScore = currentScore
            delegate?.gameManager(self, DidUpdateHighScore: highestScore)
        }
        if leftLives == 0 {
            delegate?.gameManagerDidEncounterGameOver(self)
        }
    }
}
