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

protocol FallingObjectDelegate {
    func fallingObject(fallingObject: FallingObject, didCrossThresholdPoint point: CGFloat)
}

enum FallingObjectType: String {
    
    case none
    case ballRed
    case ballBlue
    case ballGreen
    case ballYellow
    case ballCyan
    case ballGrey
    case ballPurple
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
    
    func random() -> FallingObjectType? {
        var ballType = ["ballRed","ballBlue","ballGreen","BallYellow","ballCyan","ballGrey","ballPurple"]
        ballType = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: ballType) as! [String]
        return FallingObjectType(rawValue: ballType[0])
    }
    
    var score: Int {
        switch self {

        case .ballRed : return 7
        case .ballBlue : return 6
        case .ballGreen : return 5
        case .ballYellow : return 4
        case .ballCyan : return 3
        case .ballGrey : return 2
        case .ballPurple : return 1
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
