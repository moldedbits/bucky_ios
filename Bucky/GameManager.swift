//
//  GameManager.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit

class GameManager {
    
    var currentScore:Int
    var leftLives :Int
    var highestScore: Int
    
    init(currentScore: Int, leftLives: Int, highestScore: Int){
        self.currentScore = currentScore
        self.leftLives = leftLives
        self.highestScore = highestScore
    }
    
    func checkBallIsFoulOrCatch(bucket: UIView, ball : BallView) {
        if bucket.frame.intersects(ball.frame) {
            currentScore += ball.score
            
        }else {
            leftLives -= 1
        }
        
        if currentScore > highestScore {
            highestScore = currentScore
        }
        
        
        
    }
}
