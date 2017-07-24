//
//  AnimationManager.swift
//  Bucky
//
//  Created by Vaibhav Singh on 24/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit

class AnimationManager {

    static func animateStart(score : UIButton, highscore : UIButton , lives : [UIImageView] ) {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            score.center.x -= 200
            highscore.center.x += 200
            for life in lives {
                life.center.y -= 200
            }
        }, completion: nil)
    }

    static func animateScore(button : UIButton, score : Int){
        button.setTitle("Score : \(score)", for: .normal)
    }

    static func animateHighScore(button : UIButton, score : Int){
        button.setTitle("High Score : \(score)", for: .normal)
    }

    static func animateFoul(view : UIView){
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 420, height: 800))
        redView.alpha = 0.0
        redView.backgroundColor = .red
        view.addSubview(redView)

        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.30, animations: {
                redView.alpha = 0.6
            })
            UIView.addKeyframe(withRelativeStartTime: 0.30, relativeDuration: 0.30, animations: {
                redView.alpha = 0.0
            })  
        }, completion: nil)
    }

    static func animateEnd(clouds : [UIImageView]){
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            clouds[0].center.x -= 150
            clouds[1].center.x += 170
            clouds[2].center.x -= 150
            clouds[3].center.x += 150
        }, completion: nil)
    }
}
