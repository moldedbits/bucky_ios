//
//  BucketView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BucketView: UIImageView {
    
    var numberOfBallInBucket: Int = 0
    
    init(numberOfBallInBucket: Int, image: UIImage) {
        super.init(image: image)
        
        self.numberOfBallInBucket = numberOfBallInBucket
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
}
