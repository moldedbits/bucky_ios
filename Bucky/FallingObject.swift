//
//  FallingObject.swift
//  Bucky
//
//  Created by Jeeshan Ali on 24/07/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

//velocity
//tell gameViewcontroller
//start falling
//delegate did cross threshold

protocol FallingObjectDelegate {
    func fallingObject(fallingObject: FallingObject, didCrossThresholdPoint point: CGFloat)
}

enum FallingObjectType: String {
    
    case none
    case ballRed
    case ballBlue
    case ballGreen
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
    
    var score: Int {
        switch self {
        case .ballBlue, .ballGreen, .ballRed: return 5
        default: return 0
        }
    }
}

class FallingObject: UIView {
    
    var delegate : FallingObjectDelegate?
    var type = FallingObjectType.none
    var threshHoldPoint: CGFloat = UIScreen.main.bounds.height
    var velocity: Double = 0
    var maxVelocity: Double = 20.0
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(objectType: FallingObjectType, velocity: Double, frame: CGRect) {
        self.type = objectType
        self.velocity = velocity
        
        super.init(frame: frame)
        
        let objectImageView = UIImageView(frame: bounds)
        objectImageView.contentMode = .scaleAspectFit
        objectImageView.image = type.image
        addSubview(objectImageView)
    }
    
    func startFalling() {
        let duration = maxVelocity / velocity
        let distanceToTravel = (threshHoldPoint) - frame.origin.y
        alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.alpha = 1
        }
        
        UIView.animate(withDuration: duration, delay: 1, options: UIViewAnimationOptions.curveLinear, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: distanceToTravel)
        }) { _ in
            self.delegate?.fallingObject(fallingObject: self, didCrossThresholdPoint: self.threshHoldPoint)
        }
    }
}
    



