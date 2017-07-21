//
//  BucketView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BucketView: UIView {
    
    var numberOfBallCollected: Int = 0
        
    init(frame: CGRect, numberOfBallCollected: Int) {
        super.init(frame: frame)
        
        self.numberOfBallCollected = numberOfBallCollected
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
     func incrementNumberOfBallCollected() {
            numberOfBallCollected += 1    
    }
}
