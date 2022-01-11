//
//  EmbededSubViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/10/22.
//

import Foundation
import UIKit

protocol EmbededSubViewController {
    func embedSubVC(hostViewController: UIViewController, hostViewContainer: UIView, childViewController: UIViewController, childView: UIView)
}

extension EmbededSubViewController {
    func embedSubVC(hostViewController: UIViewController, hostViewContainer: UIView, childViewController: UIViewController, childView: UIView){
        
        hostViewController.addChild(childViewController)
        hostViewContainer.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
                
        hostViewContainer.addConstraints([
            childView.leadingAnchor.constraint(equalTo: hostViewContainer.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: hostViewContainer.trailingAnchor),
            childView.topAnchor.constraint(equalTo: hostViewContainer.topAnchor),
            childView.bottomAnchor.constraint(equalTo: hostViewContainer.bottomAnchor)
        ])
        
        childViewController.didMove(toParent: childViewController)
    }
}
