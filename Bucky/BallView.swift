//
//  BallView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    var ballType: String = "red"
    var score: Int = 3
    
    init(ballType: String, score: Int, frame: CGRect) {
        super.init(frame: frame)
        
        self.ballType = ballType
        self.score = score
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
