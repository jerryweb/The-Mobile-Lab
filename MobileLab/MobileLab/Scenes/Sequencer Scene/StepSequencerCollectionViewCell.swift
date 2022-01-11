//
//  StepSequencerCollectionViewCell.swift
//  MobileLab
//
//  Created by Jerry on 1/10/22.
//

import UIKit

class StepSequencerCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var channelIndex = -1
    
    static let identifier = "StepSequencerCell"
    static func nib() -> UINib {
        return UINib(nibName: "StepSequencerViewControllerCell", bundle: nil)
    }
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
//        layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        channelIndex = -1
    }
}
