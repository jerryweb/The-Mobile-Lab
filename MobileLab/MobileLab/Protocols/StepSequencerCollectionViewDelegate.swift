//
//  StepSequencerCollectionViewDelegate.swift
//  MobileLab
//
//  Created by Jerry on 1/13/22.
//

import Foundation
import UIKit

protocol StepSequencerCollectionViewDelegate: UIViewController {
    func tapStepButton(trackIndex: Int, beatIndex: Int)
}
