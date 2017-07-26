//
//  GameViewController.swift
//  Bucky
//
//  Created by Vaibhav Singh on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    let animations = AnimationManager()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    @IBOutlet weak var cactus1: UIImageView!
    @IBOutlet weak var cactus2: UIImageView!
    @IBOutlet weak var dock: UIImageView!
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        highScoreLabel.layer.cornerRadius = 15
        highScoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 15
        scoreLabel.layer.masksToBounds = true

        //Initial positions for elements
        startButton.alpha = 0
        backgroundImage.alpha = 0
        cloud1.center.x += view.bounds.width
        cloud2.center.x -= view.bounds.width
        cloud3.center.x += view.bounds.width
        cloud4.center.x -= view.bounds.width
        highScoreLabel.center.x -= 200
        scoreLabel.center.x += 200
        for imageView in [cactus2,cactus1,dock,life1,life2,life3] {
            imageView!.center.y += 200
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseOut], animations: {
            self.backgroundImage.alpha = 1.0
        }, completion: nil)

        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 8.0, options: [.curveEaseOut,], animations: {
            self.cloud1.center.x -= self.view.bounds.width
            self.cloud2.center.x += self.view.bounds.width
            self.cloud3.center.x -= self.view.bounds.width
            self.cloud4.center.x += self.view.bounds.width
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.startButton.alpha = 1.0
            self.dock.center.y -= 200
        }, completion: nil)

        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.curveEaseOut], animations: {
            self.cactus1.center.y -= 200
            self.cactus2.center.y -= 200
        }, completion: nil)
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
//            self.startButton.alpha = 0.0
        }
        animations.animateFoul(view: view, lives: [life1,life2,life3], remainingLifeCount: 2)
        animations.animateScore(label: highScoreLabel, score: 10)
//        animations.animateEnd(clouds: [cloud1,cloud2,cloud3,cloud4], view: view)
//        animations.animateStart(score: scoreLabel, highscore: highScoreLabel, lives: [life1,life2,life3])
    }
}
