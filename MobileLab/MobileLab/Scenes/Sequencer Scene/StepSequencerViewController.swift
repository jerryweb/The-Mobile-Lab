//
//  StepSequencerViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/9/22.
//

import UIKit

class StepSequencerViewController: UIViewController, EmbeddedSubViewController {

    //MARK: Outlets
    @IBOutlet weak var stepSequencerCollectionView: UICollectionView!
    @IBOutlet weak var track0ViewContainer: UIView!
    @IBOutlet weak var track00NameLabel: UILabel!
    @IBOutlet weak var track00MuteButton: UIButton!
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        stepSequencerCollectionView.dataSource = self
        stepSequencerCollectionView.delegate = self
        stepSequencerCollectionView.register(
            StepSequencerCollectionViewCell.nib(),
            forCellWithReuseIdentifier: StepSequencerCollectionViewCell.identifier
        )
    }
    
    func setSoundEngineManager(soundEngineManager: SoundEngineManager) {
        self.soundEngineManager = soundEngineManager
    }
    
    func setChildUIViewController(childViewController: UIViewController) {
        return
    }
    
    @IBAction func tappedTrack00MuteButton(_ sender: Any) {
        print("Toggling track 0 mute")
    }

}


extension StepSequencerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return soundEngineManager.getTotalSteps()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StepSequencerCollectionViewCell.identifier,
            for: indexPath
        ) as! StepSequencerCollectionViewCell
        
        cell.configureCell(
            trackIndex: indexPath.item % soundEngineManager.maxTracks,
            stepActive: soundEngineManager.getStep(
                track: indexPath.item % soundEngineManager.maxTracks,
                beat: (indexPath.item / soundEngineManager.maxTracks)
            )
        )
                           
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        
        let width = track0ViewContainer.bounds.height
        let height = track0ViewContainer.bounds.height
        return CGSize(width: width, height: height)
    }
}
