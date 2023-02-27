//
//  SettingPresentationController.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/27/23.
//

import Foundation
import UIKit

class SettingPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.35.atScale()),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.65.atScale()))
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设定圆角
        let path = UIBezierPath(roundedRect: presentedView!.bounds, byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 26.atScale(), height: 26.atScale()))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        presentedView!.layer.mask = mask
    }
    
    
//    var backgroundViewColor = UIColor.clear {
//        didSet {
//            backgroundView.backgroundColor = backgroundViewColor
//        }
//    }
//
//    private lazy var backgroundView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.clear
//        return view
//    }()
//
//    override func presentationTransitionWillBegin() {
//        if let containerView = containerView {
//            containerView.insertSubview(backgroundView, at: 0)
//            backgroundView.snp.makeConstraints { (make) in
//                make.leading.trailing.top.bottom.equalToSuperview()
//            }
//            excuteBackgroundAnimation()
//        }
//    }
//
//    override func dismissalTransitionWillBegin() {
//        excuteBackgroundDismissAnimation()
//    }
//
//    override var shouldRemovePresentersView: Bool {
//        return false
//    }
//
//    // MARK: - private
//    private func excuteBackgroundAnimation() {
//        backgroundView.alpha = 0
//        if let coordinator = presentedViewController.transitionCoordinator {
//            coordinator.animate(alongsideTransition: { (_) in
//                self.backgroundView.alpha = 1
//            }, completion: nil)
//        }
//    }
//
//    private func excuteBackgroundDismissAnimation() {
//        if let coordinator = presentedViewController.transitionCoordinator {
//            coordinator.animate(alongsideTransition: { _ in
//                self.backgroundView.alpha = 0
//            }, completion: nil)
//        }
//    }
//
}
