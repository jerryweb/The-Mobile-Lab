//
//  MixerChannelCollectionViewCell.swift
//  MobileLab
//
//  Created by Jerry on 12/12/21.
//

import UIKit

class MixerChannelCollectionViewCell: UICollectionViewCell {
    
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
    @IBOutlet weak var channelVolumePercentageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
//        layer.shadowOpacity = 1
//        layer.shadowOffset = CGSize(width: 1, height: 1)
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
