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
    
    init(y: Int) {
        super.init(image: #imageLiteral(resourceName: "bucketImage"))
        
        self.numberOfBallInBucket = 0
        self.frame = CGRect(x: 200, y: y - 200, width: 150, height: 200)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
}
