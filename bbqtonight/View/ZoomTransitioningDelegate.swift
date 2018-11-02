//
//  ZoomTransitioningDelegate.swift
//  Lamisa
//
//  Created by Nasim on 4/6/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

protocol ZoomingViewController
{
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIViewController
}



enum TransitionState{
    case initial
    case final
}

class ZoomTransitioningDelegate: NSObject {
    var transitionDuration = 0.5
    var operation: UINavigationControllerOperation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
}
