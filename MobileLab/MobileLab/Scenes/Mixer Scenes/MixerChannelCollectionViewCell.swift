//
//  MixerChannelCollectionViewCell.swift
//  MobileLab
//
//  Created by Jerry on 12/12/21.
//

import UIKit

let volumeLabelValue = "VOL"
let panLabelValue = "PAN"
let muteLabelValue = "Mute"
let rightLabelValue = "R"
let defaultVolumeLabelValue = "75%"

class MixerChannelCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var mixerTrackVolumeFader: UISlider!{
        didSet{
            mixerTrackVolumeFader.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            mixerTrackVolumeFader.accessibilityIdentifier = "MIXER_TRACK_VOLUME_FADER"
        }
    }
    @IBOutlet weak var mixerTrackPanSlider: UISlider!{
        didSet{
            mixerTrackPanSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            mixerTrackPanSlider.accessibilityIdentifier = "MIXER_TRACK_PAN_SLIDER"
        }
    }
    @IBOutlet weak var channelVolumePercentageLabel: UILabel!{
        didSet{
            channelVolumePercentageLabel.accessibilityIdentifier = "CHANNEL_VOLUME_PERCENTAGE_LABEL"
        }
    }
    
    @IBOutlet weak var trackLabel: UILabel!{
        didSet{
            channelVolumePercentageLabel.accessibilityIdentifier = "TRACK_LABEL"
        }
    }
    
    @IBOutlet weak var muteButton: UIButton!{
        didSet{
            muteButton.accessibilityIdentifier = "MUTE_BUTTON"
        }
    }
    
    @IBOutlet weak var channelVolumeLabel: UILabel!{
        didSet{
            channelVolumeLabel.accessibilityIdentifier = "CHANNEL_VOLUME_LABEL"
        }
    }
    
    @IBOutlet weak var channelPanLabel: UILabel!{
        didSet{
            channelPanLabel.accessibilityIdentifier = "CHANNEL_PAN_LABEL"
        }
    }
    
    @IBOutlet weak var channelMuteLabel: UILabel!{
        didSet{
            channelMuteLabel.accessibilityIdentifier = "CHANNEL_MUTE_LABEL"
        }
    }
    
    @IBOutlet weak var channelRightLabel: UILabel!{
        didSet{
            channelRightLabel.accessibilityIdentifier = "CHANNEL_RIGHT_LABEL"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        channelVolumePercentageLabel.text = defaultVolumeLabelValue
        channelPanLabel.text = panLabelValue
        channelVolumeLabel.text = volumeLabelValue
        channelRightLabel.text = rightLabelValue
        channelMuteLabel.text = muteLabelValue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackLabel.text = nil
        channelVolumePercentageLabel.text = nil
    }
    
    
    @IBAction func changeChannelVolume(_ sender: Any) {
        print("Channel Volume = \(mixerTrackVolumeFader.value)")
        channelVolumePercentageLabel.text = "\(Int(mixerTrackVolumeFader.value * 100))%"
    }
    
    @IBAction func changeChannelPan(_ sender: Any) {
        print("Channel Pan = \(mixerTrackPanSlider.value)")
    }
    
    @IBAction func tapChannelMuteButton(_ sender: Any) {
        print("mute button tapped")
    }
}
