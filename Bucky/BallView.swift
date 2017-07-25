//
//  BallView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import GameplayKit

class BallView: UIImageView{
    
    var score: Int = 3
    var velocity = arc4random_uniform(6) + 5
    
    var ballArray: [UIImage] = [#imageLiteral(resourceName: "ballRed"), #imageLiteral(resourceName: "ballBlue"), #imageLiteral(resourceName: "ballGrey"), #imageLiteral(resourceName: "ballCyan"), #imageLiteral(resourceName: "ballGreen"), #imageLiteral(resourceName: "ballPurple"), #imageLiteral(resourceName: "ballYellow")]
    var ballDictionary: [UIImage: Int] = [#imageLiteral(resourceName: "ballRed"): 3,#imageLiteral(resourceName: "ballBlue"): 4, #imageLiteral(resourceName: "ballGrey"): 5, #imageLiteral(resourceName: "ballCyan"): 2,#imageLiteral(resourceName: "ballGreen"): 1, #imageLiteral(resourceName: "ballPurple"): 6, #imageLiteral(resourceName: "ballYellow"): 7]
    
    init() {
        ballArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: ballArray) as! [UIImage]
        super.init(image: ballArray[0])
        
        score = ballDictionary[ballArray[0]]!
        velocity = arc4random_uniform(6) + 5
        self.frame = CGRect(x: Int(arc4random_uniform(400)), y: 0, width: 20, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
