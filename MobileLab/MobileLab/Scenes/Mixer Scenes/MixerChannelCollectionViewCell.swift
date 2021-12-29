//
//  MixerChannelCollectionViewCell.swift
//  MobileLab
//
//  Created by Jerry on 12/12/21.
//

import UIKit

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
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
    
    func setup(soundEngineManager: SoundEngineManager) {
        self.soundEngineManager = soundEngineManager
    }
    
    @IBAction func changeChannelVolume(_ sender: Any) {
        print("Channel Volume = \(mixerTrackVolumeFader.value)")
        channelVolumePercentageLabel.text = "\(Int(mixerTrackVolumeFader.value * 100))%"
        soundEngineManager.setChannelVolume(0, mixerTrackVolumeFader.value)
    }
    
    @IBAction func changeChannelPan(_ sender: Any) {
        print("Channel Pan = \(mixerTrackPanSlider.value)")
    }
    
    @IBAction func tapChannelMuteButton(_ sender: Any) {
        print("mute button tapped")
    }
}
