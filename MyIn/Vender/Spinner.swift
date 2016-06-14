//
//  Spinner.swift
//  MyIn
//
//  Created by binglong on 16/6/7.
//  Copyright © 2016年 binglong. All rights reserved.
//

import UIKit

var kMMRingStrokeAnimationKey = "mmmaterialdesignspinner.stroke"
var kMMRingRotationAnimationKey = "mmmaterialdesignspinner.rotation"


class Spinner: UIView {
    
    var timingFunction : CAMediaTimingFunction?
    var progressLayer : CAShapeLayer = {
        let caLayer = CAShapeLayer()
        caLayer.strokeColor = UIColor.redColor().CGColor
        caLayer.fillColor = nil
        caLayer.lineWidth = 1.5
        
        return caLayer
        
    }()
    

    var isAnimating : Bool
    var hidesWhenStopped : Bool
    
    override init(frame: CGRect) {
        self.isAnimating = false
        self.hidesWhenStopped = true
        super.init(frame:frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.isAnimating = false
        self.hidesWhenStopped = true
        super.init(coder: aDecoder)
        self.initialize()
//        fatalError("init(coder:) has not been implemented")
        
    }

    func initialize() {
        self.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.addSublayer(self.progressLayer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Spinner.resetAnimations), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func resetAnimations() {
        if self.isAnimating {
            self.stopAnimating()
            self.startAnimating()
        }
    }
    
    func setAnimating(animate : Bool)  {
        animate ? self.startAnimating() : self.stopAnimating()
    }
    
    //Mark:123
    func stopAnimating() {
        
        if !self.isAnimating {
            return
        }
        
        self.progressLayer.removeAnimationForKey(kMMRingStrokeAnimationKey)
        self.progressLayer.removeAnimationForKey(kMMRingRotationAnimationKey)
        self.isAnimating = false
        
        if self.hidesWhenStopped {
            self.hidden = true
        }
    }
    
    func startAnimating() {
        
        if self.isAnimating {
            return
        }
        
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 2
        animation.fromValue = (0)
        animation.toValue = (2 * M_PI)
        animation.repeatCount = Float.infinity
        self.progressLayer.addAnimation(animation, forKey: kMMRingRotationAnimationKey)
        
        let headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1
        headAnimation.fromValue = (0)
        headAnimation.toValue = (0.25)
        headAnimation.timingFunction = self.timingFunction
        
        let tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1
        tailAnimation.timingFunction = self.timingFunction
//
        let endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1
        endHeadAnimation.timingFunction = self.timingFunction
        
        let endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1
        endTailAnimation.toValue = 1
        endTailAnimation.timingFunction = self.timingFunction
//
        let animations = CAAnimationGroup()
        animations.duration = 1.5
//        animations.animations = [headAnimation, tailAnimation]
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]

        animations.repeatCount = Float.infinity
        self.progressLayer.addAnimation(animations, forKey: kMMRingStrokeAnimationKey)
        
        self.isAnimating = true
        
        if self.hidesWhenStopped {
            self.hidden = false
        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))
        self.updatePath()
        
    }
    
    func updatePath() {
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        let raduis = min(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2
        
        let startAngle : CGFloat = 0
        let endAngle : CGFloat = 2.0 * CGFloat(M_PI)
        
        let path : UIBezierPath = UIBezierPath.init(arcCenter: center, radius: raduis, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        self.progressLayer.path = path.CGPath
        
        self.progressLayer.strokeStart = 0
        self.progressLayer.strokeEnd = 0
        
    }
    
}
