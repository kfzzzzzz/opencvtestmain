//
//  LeftProfileDismissAnimation.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/23/23.
//

import Foundation
import UIKit

class LeftProfileDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 0.5
    var delay: TimeInterval = 0.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view( forKey: UITransitionContextViewKey.from)
        else {
            return
        }
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: {
            fromView.frame.origin.x = -UIScreen.main.bounds.width
            //fromView.alpha = 0.0
        }) { (finished) in
            //fromView.alpha = 1.0
            transitionContext.completeTransition(finished)
        }
    }
}

