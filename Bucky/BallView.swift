//
//  BallView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BallView: UIImageView{
    
    var ballType: String = "red"
    var score: Int = 3
    
    init(ballType: String, score: Int, image: UIImage) {
        super.init(image: image)
        
        self.ballType = ballType
        self.score = score
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
