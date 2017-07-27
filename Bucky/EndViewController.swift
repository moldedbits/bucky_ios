//
//  EndViewController.swift
//  Bucky
//
//  Created by Koushal Sharma on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var currentScoreLabel: UILabel! {
        didSet {
            currentScoreLabel.text = "\(currentScore)"
        }
    }
    @IBOutlet weak var highScoreLabel: UILabel! {
        didSet {
            highScoreLabel.text = "\(highScore)"
        }
    }
    @IBOutlet weak var replayButton: UIButton! {
        didSet {
            replayButton.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var homePageButton: UIButton! {
        didSet {
            homePageButton.layer.cornerRadius = 20
        }
    }
    
    var currentScore: Int {
        guard let currentScore = UserDefaults.standard.value(forKey: UserDefaultsKey.currentScore) as? Int else {return 0}
        return currentScore
    }
    var highScore: Int {
        guard let highScore = UserDefaults.standard.value(forKey: UserDefaultsKey.highestScore) as? Int else {return 0}
        return highScore
    }
    
    @IBAction func replayButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    @IBAction func homePageButtonTapped(_ sender: Any) {
     navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}
