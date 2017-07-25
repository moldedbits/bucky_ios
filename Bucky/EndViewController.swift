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
            currentScoreLabel.text = "Current Score \(currentScore)"
        }
    }
    @IBOutlet weak var highScoreLabel: UILabel! {
        didSet {
            highScoreLabel.text = "High Score \(highScore)"
        }
    }
    @IBOutlet weak var homePageButton: UIButton! {
        didSet {
            homePageButton.layer.cornerRadius = 20
        }
    }
    
    var currentScore: Int = 0
    var highScore: Int = 0
    
    @IBAction func homePageButtonTapped(_ sender: Any) {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
