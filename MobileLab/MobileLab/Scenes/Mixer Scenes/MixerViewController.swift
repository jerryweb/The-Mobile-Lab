//
//  MixerViewController.swift
//  MobileLab
//
//  Created by Jerry on 12/12/21.
//

import UIKit

class MixerViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var masterVolumePercentageLabel: UILabel!{
        didSet{
            masterVolumePercentageLabel.accessibilityIdentifier = "MASTER_VOLUME_PERCENTAGE_LABEL"
        }
    }
    
    @IBOutlet weak var masterTextLabel: UILabel!{
        didSet{
            masterTextLabel.accessibilityIdentifier = "MASTER_TEXT_LABEL"
        }
    }
    
    @IBOutlet weak var masterVolumeFader: UISlider!{
        didSet{
            masterVolumeFader.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            masterVolumeFader.accessibilityIdentifier = "MASTER_VOLUME_FADER"
        }
    }
    
    @IBOutlet weak var mixerCollectionView: UICollectionView!
    
    let dummyTracks = [1,2,3,4,5,6,7,8]
    var soundEngineManager = SoundEngineManager()
    private var transportControlsVC : TransportControlsViewController?

    @IBOutlet weak var transportControlsViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let transportControlsVC = transportControlsVC else {
            return
        }
        transportControlsVC.embedSubVC(hostViewController: self, hostViewContainer: transportControlsViewContainer, childViewController: transportControlsVC, childView: transportControlsVC.view)
        transportControlsVC.setUp(soundEngineManager: soundEngineManager)
        
        mixerCollectionView.delegate = self
        mixerCollectionView.dataSource = self
        //        mixerCollectionView.register(MixerChannelCollectionViewCell.self, forCellWithReuseIdentifier: "MixerChannelCell")
        //        mixerCollectionView.register("MixerChannelCollectionViewCell", forCellWithReuseIdentifier: "MixerChannelCell")
                
        mixerCollectionView.register(MixerTrackCollectionViewCell.nib(), forCellWithReuseIdentifier: MixerTrackCollectionViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard  let transportControlsVC = transportControlsVC else {
            print("no transport controls view controller found")
            return
        }
        transportControlsVC.embedSubVC(hostViewController: self, hostViewContainer: transportControlsViewContainer, childViewController: transportControlsVC, childView: transportControlsVC.view)
    }
    
    func setUp(soundEngineManager: SoundEngineManager, transportControlsVC: TransportControlsViewController){
        self.soundEngineManager = soundEngineManager
        self.transportControlsVC = transportControlsVC
    }
}

extension MixerViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dummyTracks.count)
        return dummyTracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MixerTrackCollectionViewCell.identifier, for: indexPath) as! MixerTrackCollectionViewCell
        
        cell.configureCell(mixerTrackModel: soundEngineManager.mixerTrackModels[indexPath.item])
        cell.delegate = self
        return cell
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = mixerCollectionView.bounds.width / 4
        let height = mixerCollectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}

extension MixerViewController: MixerTrackCollectionViewDelegate {
    func tapChannelMuteButton(trackIndex: Int) {
        soundEngineManager.muteChannel(trackIndex)
        print("Tapped Mute button for \(trackIndex)")
    }
    
    func changeChannelVolume(trackIndex: Int, vol: Float) {
        soundEngineManager.setChannelVolume(trackIndex, vol)
        print("Channel \(trackIndex) Volume = \(vol)")
    }
    
    func changeChannelPan(trackIndex: Int, pan: Float) {
        soundEngineManager.setChannelPan(trackIndex, pan)
        print("Channel \(trackIndex)  Pan = \(pan)")
    }
}

