//
//  GameViewController.swift
//  Bucky
//
//  Created by Vaibhav Singh on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
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
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var highScoreButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        highScoreButton.layer.cornerRadius = 15
        scoreButton.layer.cornerRadius = 15

        //Initial positions for elements
        startButton.alpha = 0
        backgroundImage.alpha = 0
        cloud1.center.x += view.bounds.width
        cloud2.center.x -= view.bounds.width
        cloud3.center.x += view.bounds.width
        cloud4.center.x -= view.bounds.width
        highScoreButton.center.x -= 200
        scoreButton.center.x += 200
        for imageView in [cactus2,cactus1,dock,life1,life2,life3] {
            imageView!.center.y += 200
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        viewWillAppear(animated)

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

        UIView.animate(withDuration: 1.0, delay: 0.3, options: [.curveEaseOut], animations: {
            self.cactus1.center.y -= 200
            self.cactus2.center.y -= 200
        }, completion: nil)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.startButton.alpha = 0.0
        }
        AnimationManager.animateStart(score: scoreButton, highscore: highScoreButton, lives: [life1,life2,life3])
    }
    
}
