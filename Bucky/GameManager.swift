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
    func gameManagerDidGameStart(_ gameManager: GameManager, bucket: BucketView, ball: BallView)
    func gameManagerDidUpdateScore(_ gameManager: GameManager, newScore: Int)
    func gameManagerIncrementBallInBucket(_ gameManager: GameManager, bucket: BucketView)
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
    
    func gameStartOrReset(view : UIView) {
        UserDefaults.standard.set(0, forKey: "highestScore")
        GameManager(currentScore: 0, leftLives: 3)
        
        let bucketView = BucketView(y: Int(view.frame.height) - 200)
        
        let ballView = BallView()
        delegate?.gameManagerDidGameStart(self, bucket: bucketView, ball: ballView)
        //FallingObject().startFalling(ball: ballView)
        
        repeatBalls()
    }
    
    @objc func spawnNewFallingObject() {
        let ballView = BallView()
         //FallingObject().startFalling(ball: ballView)
    }
    
    func repeatBalls() {
        var timer = Timer()
        let delay = 0.5
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(spawnNewFallingObject), userInfo: nil, repeats: true)
        
    }
    
    func checkBallIsFoulOrCatch(bucket: BucketView, ball : BallView) {
        if bucket.frame.intersects(ball.frame) {
            currentScore += ball.score
            delegate?.gameManagerIncrementBallInBucket(self,bucket: bucket )
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
