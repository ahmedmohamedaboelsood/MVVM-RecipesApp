//
//  UINavigetionController + Extentions.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 24/08/2023.
//

import Foundation
import UIKit

extension UINavigationController{
    func pushViewControllerWithModalTransition(viewController: UIViewController) {
        setupPushTransition()
        self.pushViewController(viewController, animated: false)
    }

    func setupPushTransition () {
        let transition: CATransition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: kCATransition)
    }
}
