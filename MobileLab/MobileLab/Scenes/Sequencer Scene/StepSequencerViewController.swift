//
//  StepSequencerViewController.swift
//  MobileLab
//
//  Created by Jerry on 1/9/22.
//

import UIKit

class StepSequencerViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var stepSequencerCollectionView: UICollectionView!
    @IBOutlet weak var track0ViewContainer: UIView!
    @IBOutlet weak var track00NameLabel: UILabel!
    @IBOutlet weak var track00MuteButton: UIButton!
    
    //MARK: Properties
    var soundEngineManager = SoundEngineManager()
    var muteButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepSequencerCollectionView.dataSource = self
        stepSequencerCollectionView.delegate = self
        stepSequencerCollectionView.register(
            StepSequencerCollectionViewCell.nib(),
            forCellWithReuseIdentifier: StepSequencerCollectionViewCell.identifier
        )
        
        muteButtons.reserveCapacity(soundEngineManager.maxTracks)
        addMuteButtonsToArray()
        configureTracks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTracks()
    }
}



extension StepSequencerViewController {
    @IBAction func tappedTrack00MuteButton(_ sender: Any) {
        print("Toggling track 0 mute")
        soundEngineManager.muteChannel(0)
        track00MuteButton.setMuteButtonImage(track: 0, bool: soundEngineManager.isChannelMuted(0))
    }

    func configureTracks(){
        print(soundEngineManager.mixerTrackModels.count)
        track00NameLabel.text = soundEngineManager.mixerTrackModels[0].trackName
        for index in 0..<muteButtons.count {
            muteButtons[index].setMuteButtonImage(track: index, bool: soundEngineManager.isChannelMuted(index))
        }
    }
    
    func addMuteButtonsToArray(){
        muteButtons.append(track00MuteButton)
    }
}

extension StepSequencerViewController: EmbeddedSubViewController {
    func setChildUIViewController(childViewController: UIViewController) {
        return
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
            beatIndex: (indexPath.item / soundEngineManager.maxTracks),
            stepActive: soundEngineManager.getStep(
                track: indexPath.item % soundEngineManager.maxTracks,
                beat: (indexPath.item / soundEngineManager.maxTracks)
            )
        )
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let _ = collectionViewWidth - spaceBetweenCells
        
        let width = track0ViewContainer.bounds.height 
        let height = track0ViewContainer.bounds.height
        return CGSize(width: width, height: height)
    }
}

extension StepSequencerViewController: StepSequencerCollectionViewDelegate {
    func tapStepButton(trackIndex: Int, beatIndex: Int) {
        soundEngineManager.toggleStep(track: trackIndex, beat: beatIndex)
    }
    
    func  tapMuteButton(trackIndex: Int) {
        soundEngineManager.muteChannel(trackIndex)
    }
}
