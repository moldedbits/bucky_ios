//
//  GameViewController.swift
//  Bucky
//
//  Created by Vaibhav Singh on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    @IBOutlet weak var cactus1: UIImageView!
    @IBOutlet weak var cactus2: UIImageView!
    @IBOutlet weak var dock: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //Initial positions for elements
        backgroundImage.alpha = 0
        cloud1.center.x += view.bounds.width
        cloud2.center.x -= view.bounds.width
        cloud3.center.x += view.bounds.width
        cloud4.center.x -= view.bounds.width
        cactus1.center.y -= 150
        cactus2.center.y -= 150
        dock.center.y -= 200

    }

    override func viewDidAppear(_ animated: Bool) {
        viewWillAppear(animated)

        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseOut], animations: {
            self.backgroundImage.alpha = 1.0
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 8.0, options: [.curveEaseOut,], animations: {
            self.cloud1.center.x -= self.view.bounds.width
            self.cloud2.center.x += self.view.bounds.width
            self.cloud3.center.x -= self.view.bounds.width
            self.cloud4.center.x += self.view.bounds.width
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [], animations: {
            self.cactus1.center.y += 150
            self.cactus2.center.y += 150
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 8.0, options: [], animations: {
            self.dock.center.y += 200
        }, completion: nil)
    }

}
