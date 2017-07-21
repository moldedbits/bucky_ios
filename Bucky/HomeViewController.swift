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
                highScoreLabel.text = "High Score  \(highScore)"
            }
    }
    @IBOutlet weak var playGameButton: UIButton! {
        didSet {
            playGameButton.layer.cornerRadius = 20
            playGameButton.layer.masksToBounds = true
        }
    }
    
    var highScore: Int = 0
    
    @IBAction func playGameButtonTapped(_ sender: UIButton) {
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playGameButton.center.x  -= view.bounds.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
