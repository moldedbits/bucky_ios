//
//  AnimationManager.swift
//  Bucky
//
//  Created by Vaibhav Singh on 24/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AnimationManager {

    var audioPlayer = AVAudioPlayer()

    func animateStart(score : UILabel, highscore : UILabel , lives : [UIImageView] ) {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            score.center.x -= 200
//            highscore.center.x += 200
            for life in lives {
                life.center.y -= 200
            }
        }, completion: nil)
    }

    func animateScore(label : UILabel, score : Int){

//        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//
//        animation.repeatCount =  5
//        animation.duration = (0.1)/TimeInterval(animation.repeatCount)
//        animation.autoreverses = true
//        animation.byValue =  -7
//        label.layer.add(animation, forKey: "shake")

//        UIView.animate(withDuration: 0.25, delay: 0, options: [.autoreverse], animations: {
//            label.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//        },completion: nil)
    }

    func animateFoul(view : UIView, lives : [UIImageView], remainingLifeCount : Int) {
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

        switch remainingLifeCount {
        case 2:
            lives[2].backgroundColor = UIColor.black
            lives[2].alpha = 0.2
        case 1:
            lives[1].backgroundColor = UIColor.black
            lives[1].alpha = 0.2
        case 0:
            lives[0].backgroundColor = UIColor.black
            lives[0].alpha = 0.2
        default:
            print("error....lives out of range")
        }
    }

    func animateEnd(clouds : [UIImageView]){
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            clouds[0].center.x -= 150
            clouds[1].center.x += 170
            clouds[2].center.x -= 150
            clouds[3].center.x += 150
        }, completion: nil)
        //Game over banner
    }
}
