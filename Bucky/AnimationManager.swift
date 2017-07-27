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

    private var audioPlayer = AVAudioPlayer()

    func animateStart(score: UILabel, highscore: UILabel, lives: [UIImageView], bucket: UIImageView) {
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            bucket.center.x += 400
            score.center.x -= 200
            highscore.center.x += 200
            for life in lives {
                life.center.y -= 200
            }
        })
        playSound(soundName: SoundName.start.rawValue)
    }

    func animateScore(label: UILabel, score: Int) {
        label.text = "\(score)"
        animateKeyframes(duration: 0.4, frames: [
            {label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)},
            {label.transform = CGAffineTransform(scaleX: 0.834, y: 0.834)}] )
        playSound(soundName: SoundName.hit.rawValue)
    }

    func animateFoul(view: UIView, lives: [UIImageView], remainingLifeCount: Int) {
        let redView = createView(color: .red)
        view.addSubview(redView)
        animateKeyframes(duration: 0.5, frames: [{redView.alpha = 0.6},
                                                 {redView.alpha = 0.0}])
        switch remainingLifeCount {
        case 0...2:
            lives[remainingLifeCount].backgroundColor = UIColor.black
            lives[remainingLifeCount].alpha = 0.2
        default:
            print("ERROR : Remaining lives out of range")
        }
        playSound(soundName: SoundName.foul.rawValue)
    }

    func animateEnd(clouds: [UIImageView], view: UIView, life: UIImageView) {
        life.backgroundColor = UIColor.black
        life.alpha = 0.2
        let gameOverBanner = UIImageView(image: #imageLiteral(resourceName: "GameOver"))
        gameOverBanner.frame = CGRect(x: 0, y: 0, width: 10, height: 5)
        gameOverBanner.center = view.center
        let dimView = createView(color: .black)
        view.addSubview(dimView)
        view.addSubview(gameOverBanner)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: [], animations: {
            clouds[0].center.x -= 150
            clouds[1].center.x += 170
            clouds[2].center.x -= 150
            clouds[3].center.x += 150
            dimView.alpha = 0.4
            gameOverBanner.transform = gameOverBanner.transform.scaledBy(x: 25, y: 25)
        })
        playSound(soundName: SoundName.end.rawValue)
    }

    private func playSound(soundName: String){
        guard let audioUrl = Bundle.main.url(forResource: soundName, withExtension: "mp3")
            else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func createView(color: UIColor, alpha: Double = 0.0) -> UIView {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 736))
        newView.alpha = 0.0
        newView.backgroundColor = color
        return newView
    }

    private func animateKeyframes(duration : Double, frames: [()->Void]){
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            for (index,frame) in frames.enumerated(){
                UIView.addKeyframe(withRelativeStartTime: 0 + Double(index)*(duration/Double(frames.count)), relativeDuration: duration/Double(frames.count), animations: {
                    frame()
                })
            }
        })
    }
}
