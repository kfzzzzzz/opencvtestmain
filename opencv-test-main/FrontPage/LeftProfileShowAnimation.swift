//
//  LeftProfileShowAnimation.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/23/23.
//

import Foundation
import UIKit

class LeftProfileShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 0.5
    var delay: TimeInterval = 0.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to),
              let toView = transitionContext.view( forKey: UITransitionContextViewKey.to)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toViewController)
        containerView.addSubview(toView)
        
        toView.frame.origin.x = -UIScreen.main.bounds.width
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut) {
            toView.frame.origin.x = 0
        } completion: { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
