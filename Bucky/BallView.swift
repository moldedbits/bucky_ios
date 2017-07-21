//
//  BallView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    var ballType: String
    var score: Int
    init(ballType: String, score: Int, frame: CGRect) {
        self.ballType = ballType
        self.score = score
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
