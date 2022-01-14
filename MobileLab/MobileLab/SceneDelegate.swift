//
//  SceneDelegate.swift
//  MobileLab
//
//  Created by Jerry on 11/15/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    public let soundEngineManager = SoundEngineManager()
    let transportControlsVC = TransportControlsViewController(nibName: "TransportViewController", bundle: nil)
    // LOOK UP CONTENT HUGGING AND COMPRESSION PRIORITY
    
    func createDrumPadHostVC() -> UIViewController {
            let drumPadHostVC = DrumPadHostViewController(nibName: "DrumPadHostViewController", bundle: nil)
            drumPadHostVC.tabBarItem = UITabBarItem(title: "Drum Pad", image: UIImage(systemName: "square.grid.3x3.fill"), tag: 0)
            drumPadHostVC.soundEngineManager = soundEngineManager
            drumPadHostVC.setChildUIViewController(childViewController: transportControlsVC)
        return drumPadHostVC
       }
    
    func createMixerVC() -> UIViewController {
        let mixerVC = MixerViewController(nibName: "MixerViewController", bundle: nil)
        mixerVC.tabBarItem = UITabBarItem(title: "Mixer", image: UIImage(systemName: "dial.max"), tag: 1)
        mixerVC.soundEngineManager = soundEngineManager
        mixerVC.setChildUIViewController(childViewController: transportControlsVC)
        return mixerVC
    }
    
    func createSequencerVC() -> UIViewController {
        let sequencerVC = MainSequencerViewController(nibName: "MainSequencerViewController", bundle: nil)
        sequencerVC.tabBarItem = UITabBarItem(title: "Sequencer", image: UIImage(systemName: "square.grid.3x3.topleft.fill"), tag: 2)
        sequencerVC.soundEngineManager = soundEngineManager
        sequencerVC.setChildUIViewController(childViewController: transportControlsVC)
        return sequencerVC
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        transportControlsVC.soundEngineManager = soundEngineManager
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [
            createDrumPadHostVC(),
            createMixerVC(),
            createSequencerVC()
        ]
        soundEngineManager.createTracks(count: soundEngineManager.maxTracks)
        soundEngineManager.loadTestSounds()
        
        soundEngineManager.engine.startEngine()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

