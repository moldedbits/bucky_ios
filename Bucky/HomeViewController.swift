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
    
    var highScore: Int = 0
    
    @IBAction func playGameButtonTapped(_ sender: UIButton) {
        print("Tapped")
        // check for end game view controller
        let endViewController = EndViewController()
        navigationController?.pushViewController(endViewController, animated: true)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.8, delay: 0.7, options: [.autoreverse,.repeat,.allowUserInteraction],animations: {
        self.playGameButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
