//
//  HomeViewController.swift
//  Bucky
//
//  Created by Koushal Sharma on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel! {
        didSet {
                highScoreLabel.text = "High Score \(highScore)"
            }
    }
    @IBOutlet weak var playGameButton: UIButton! {
        didSet {
            playGameButton.layer.cornerRadius = 20
            playGameButton.layer.masksToBounds = true
        }
    }
    
    var highScore: Int {
        guard let highScore = UserDefaults.standard.value(forKey: UserDefaultsKey.highestScore) as? Int else {return 0}
        return highScore
    }
    
    @IBAction func playGameButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.7, delay: 0, options: [.autoreverse,.repeat,.allowUserInteraction],animations: {
        self.playGameButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        },completion: nil)
    }
}
