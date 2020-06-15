//
//  AnimateNavigator.swift
//  MyProject
//
//  Created by Dev on 09.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit

class AnimateNavigator {

    private var navigator: UINavigationController!

    init(_ navigator: UINavigationController) {
        self.navigator = navigator
    }

    func showPush(_ transitionSubType: CATransitionSubtype = .fromTop,
              _ transitionType: CATransitionType = .reveal) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = transitionType
        transition.subtype = transitionSubType
        navigator.view.layer.add(transition, forKey: kCATransition)
    }

    func showPop(_ transitionSubType: CATransitionSubtype = .fromTop,
    _ transitionType: CATransitionType = .reveal) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = transitionType
        transition.subtype = transitionSubType
        navigator.view.layer.add(transition, forKey: kCATransition)
    }
}
