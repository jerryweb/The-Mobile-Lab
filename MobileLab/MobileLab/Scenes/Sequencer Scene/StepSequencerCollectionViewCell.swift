//
//  StepSequencerCollectionViewCell.swift
//  MobileLab
//
//  Created by Jerry on 1/10/22.
//

import UIKit

class StepSequencerCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var trackIndex = -1
    private var stepActive = false
    
    let squareFillImage = UIImage(systemName: "square.fill")?.withRenderingMode(.alwaysOriginal)
    let squareEmptyImage = UIImage(systemName: "square")?.withRenderingMode(.alwaysOriginal)
    
    static let identifier = "StepSequencerCell"
    static func nib() -> UINib {
        return UINib(nibName: "StepSequencerViewControllerCell", bundle: nil)
    }
    
    //MARK: Outlets
    @IBOutlet weak var stepButton: UIButton! {
        didSet{
            stepButton.accessibilityLabel = "STEP_BUTTON"
        }
    }
    
    //MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackIndex = -1
    }
    
    func configureCell(trackIndex: Int, stepActive: Bool){
        self.stepActive = stepActive
        self.trackIndex = trackIndex
    }
    
    @IBAction func stepTriggered(_ sender: Any) {
        print("trigger step \(trackIndex)")
        stepActive = !stepActive
        
        if stepActive {
            stepButton.setImage(squareFillImage, for: .normal)
        }
        else {
            stepButton.setImage(squareEmptyImage, for: .normal)
        }
    }
}
