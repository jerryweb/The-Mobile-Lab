//
//  SequencerCollectionViewCell.swift
//  MobileLab
//
//  Created by Jerry on 1/6/22.
//

import UIKit

class SequencerCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    private var channelIndex = -1
    static func nib() -> UINib {
        return UINib(nibName: "SequencerCollectionViewCell", bundle: nil)
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var trackNameLabel: UILabel!{
        didSet{
            trackNameLabel.accessibilityIdentifier = "TRACK_NAME_LABEL"
        }
    }
    @IBOutlet weak var trackMuteButton: UIButton!{
        didSet{
            trackMuteButton.accessibilityIdentifier = "TRACK_MUTE_BUTTON"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        channelIndex = -1
    }
    
    func configureCell(mixerTrackModel: MixerTrackModel){
        trackNameLabel.text = mixerTrackModel.trackName
        channelIndex = mixerTrackModel.trackNumber
    }
    
    
}
