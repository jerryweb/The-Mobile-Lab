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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mixerCollectionView.delegate = self
        mixerCollectionView.dataSource = self
    }
    
    func setUp(soundEngineManager: SoundEngineManager){
        self.soundEngineManager = soundEngineManager
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    
}


extension MixerViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dummyTracks.count)
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MixerChannelCell", for: indexPath)
        return cell
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = mixerCollectionView.bounds.width / 4
        let height = mixerCollectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
