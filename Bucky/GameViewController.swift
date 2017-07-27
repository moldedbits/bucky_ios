//
//  GameViewController.swift
//  Bucky
//
//  Created by Vaibhav Singh on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameManagerProtocol, FallingObjectDelegate {

    let gameManager = GameManager()
    let animations = AnimationManager()

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
    @IBOutlet weak var bucket: UIImageView!
    @IBOutlet weak var bucketXConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragged(_:)))
        bucket.addGestureRecognizer(panGesture)

        gameManager.delegate = self
        gameManager.gameStart()
        let highScore = UserDefaults.standard.integer(forKey: UserDefaultsKey.highestScore)
        animations.animateScore(label: highScoreLabel, score: highScore)
        animations.animateScore(label: scoreLabel, score: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setInitialConfig()
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
            self.dock.center.y -= 200
        }, completion: nil)

        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.curveEaseOut], animations: {
            self.cactus1.center.y -= 200
            self.cactus2.center.y -= 200
        }, completion: nil)

        animations.animateStart(score: scoreLabel, highscore: highScoreLabel, lives: [life1,life2,life3], bucket: bucket)
    }

    func setInitialConfig(){
        bucket.isUserInteractionEnabled = true
        highScoreLabel.layer.cornerRadius = 15
        highScoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 15
        scoreLabel.layer.masksToBounds = true
        //Initial positions for elements
        backgroundImage.alpha = 0
        cloud1.center.x += view.bounds.width
        cloud2.center.x -= view.bounds.width
        cloud3.center.x += view.bounds.width
        cloud4.center.x -= view.bounds.width
        highScoreLabel.center.x -= 200
        scoreLabel.center.x += 200
        bucket.center.x -= 400
        for imageView in [cactus2, cactus1, dock, life1, life2, life3] {
            imageView!.center.y += 200
        }
    }

    func addViewsToDock(){
        dock.addSubview(life1)
        dock.addSubview(life2)
        dock.addSubview(life3)
        dock.addSubview(highScoreLabel)
        dock.addSubview(scoreLabel)
        view.bringSubview(toFront: dock)
    }

    @objc func dragged(_ sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed:
            UIView.animate(withDuration: 0.05, animations: {
                self.bucket.center.x = sender.location(in: self.view).x
                self.bucketXConstraint.constant = sender.location(in: self.view).x - self.bucket.frame.width/2
            })
        default:
            return
        }
    }
    //Delegation Methods
    func fallingObject(fallingObject: FallingObject, didCrossThresholdPoint point: CGFloat) {
        if !gameManager.isGameOver {
            gameManager.checkBallIsFoulOrCatch(bucket: bucket, ball: fallingObject)
        }
        fallingObject.removeFromSuperview()
    }

    func gameManager(_ gameManager: GameManager, didGameStart fallingObject: FallingObject) {
        fallingObject.delegate = self
        self.gameManager(gameManager, didSpawnNewFallingObject: fallingObject)
    }

    func gameManager(_ gameManager: GameManager, didSpawnNewFallingObject fallingObject: FallingObject) {
        fallingObject.delegate = self
        fallingObject.threshHoldPoint = bucket.frame.minY
        view.addSubview(fallingObject)
        fallingObject.startFalling()
    }

    func gameManager(_ gameManager: GameManager, didUpdateCurrentScore newScore: Int) {
        animations.animateScore(label: scoreLabel, score: newScore)
    }

    func gameManager(_ gameManager: GameManager, didUpdateLives lives: Int) {
        animations.animateFoul(view: view, lives: [life1,life2,life3], remainingLifeCount: lives)
    }

    func gameManager(_ gameManager: GameManager, didRemoveFromSuperView ball: FallingObject) {
        ball.removeFromSuperview()
    }

    func gameManager(_ gameManager: GameManager, didUpdateHighScore highScore: Int) {
        animations.animateScore(label: highScoreLabel, score: highScore)
    }

    func gameManagerDidEncounterGameOver(_ gameManager: GameManager) {
        animations.animateEnd(clouds: [cloud1,cloud2,cloud3,cloud4], view: view, life: life1)
        animations.delay(3.5) {
            self.navigationController?.pushViewController(EndViewController(), animated: true)
        }
    }

}

