//
//  BucketView.swift
//  Bucky
//
//  Created by Sunita Moond on 21/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

class BucketView: UIImageView {
    
    var numberOfBallCollected: Int = 0
    
    init(numberOfBallCollected: Int, image: UIImage) {
        super.init(image: image)
        
        self.numberOfBallCollected = numberOfBallCollected
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
    
    func incrementNumberOfBallCollected() {
        numberOfBallCollected += 1
    }
}
