//
//  FallingObject.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

class FallingObject {
    
    var ballName : [String]  = ["Red", "Green", "Blue"]
    let ballScore : [String: Int] = ["red" : 3, "green" : 2, "blue" : 1 ]
    
    let bucket = BucketView(frame: CGRect(x: 0, y: 100, width: 100, height: 100), numberOfBallCollected: 0)
    
    let gameManager = GameManager(currentScore: 0, leftLives: 3)
    
    let panGesture = UIPanGestureRecognizer(target: ViewController(), action: #selector(dragged(_:)))
    
    @objc func createBall(){
        ballName = (GKRandomSource.sharedRandom().arrayByShufflingObjects(in: ballName) as! [String])
        let ball = BallView(ballType: ballName[0], score: self.ballScore[ballName[0]]!, frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        ball.animateBall()
    }
    
    func repeatBalls() {
        var timer = Timer()
        let delay = 0.5
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(createBall), userInfo: nil, repeats: true)
    }
    
    @objc func dragged(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .changed:
            bucket.frame.origin.x = sender.location(in :UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))).x
        default:
            break
        }
    }
}

extension UIView {
    
    func animateBall() {
        UIView.animate(withDuration: 1) {
            self.frame.origin.y = 3000
            if self.frame.origin.y + self.frame.height == FallingObject().bucket.frame.origin.y {
                FallingObject().gameManager.checkBallIsFoulOrCatch(bucket: FallingObject().bucket, ball: self as! BallView)
            }
        }
    }
}
