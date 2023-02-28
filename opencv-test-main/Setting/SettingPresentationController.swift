//
//  SettingPresentationController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/27/23.
//

import Foundation
import UIKit

class SettingPresentationController: UIPresentationController {

    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        //let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: .none)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: self.containerView!.frame.width*0.1, y: self.containerView!.frame.height * 0.3),
               size: CGSize(width: self.containerView!.frame.width*0.8, height: self.containerView!.frame.height*0.4))
    }

    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.blurEffectView.backgroundColor = UIColor.black
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0.5
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设定圆角
        let path = UIBezierPath(roundedRect: presentedView!.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 30.atScale(), height: 30.atScale()))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        presentedView!.layer.mask = mask
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }

    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
  }

