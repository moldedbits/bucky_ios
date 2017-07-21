//
//  BucketView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BucketView: UIView {
    
    var numberOfBallCollected: Int
    init(numberOfBallCollected: Int, frame: CGRect){
        self.numberOfBallCollected = numberOfBallCollected
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
}
