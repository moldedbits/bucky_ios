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
    func gameManagerDidEncounterGameOver(_ gameManager: GameManager)
    func gameManagerDidUpdateScore(_ gameManager: GameManager, newScore: Int)
    func gameManagerDidUpdateLives(_ gameManager: GameManager, leftLives: Int)
    func gameManagerDidUpdateHighScore(_ gameManager: GameManager, highScore: Int)
    func gameManagerIncrementBallInBucket(_ gameManager: GameManager)
}

class GameManager  {
    
    var currentScore:Int
    var leftLives :Int
    var highestScore: Int = 0
    var delegate: GameManagerProtocol?
    
    init(currentScore: Int, leftLives: Int, viewController: UIViewController){
        self.currentScore = currentScore
        self.leftLives = leftLives
        self.highestScore = UserDefaults.standard.integer(forKey: "highestScore") as! Int
    }
    
    func checkBallIsFoulOrCatch(bucket: BucketView, ball : BallView) {
        if bucket.frame.intersects(ball.frame) {            
            currentScore += ball.score
            delegate?.gameManagerIncrementBallInBucket(self)
            delegate?.gameManagerDidUpdateScore(self, newScore: currentScore)
        }else {
            leftLives -= 1
            delegate?.gameManagerDidUpdateLives(self, leftLives: leftLives)
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
