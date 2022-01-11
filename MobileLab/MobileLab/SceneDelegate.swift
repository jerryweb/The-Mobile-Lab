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
    static let trackCount = 16
    
    // LOOK UP CONTENT HUGGING AND COMPRESSION PRIORITY
    
    func createDrumPadHostVC() -> UIViewController {
           let drumPadHostVC = DrumPadHostViewController(nibName: "DrumPadHostViewController", bundle: nil)
           drumPadHostVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0 )
            drumPadHostVC.setUp(soundEngineManager: soundEngineManager, transportControlsVC: transportControlsVC)
        return drumPadHostVC
       }
    
    func createMixerVC() -> UIViewController {
        let mixerVC = MixerViewController(nibName: "MixerViewController", bundle: nil)
        mixerVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1 )
        mixerVC.setUp(soundEngineManager: soundEngineManager, transportControlsVC: transportControlsVC)
        return mixerVC
    }
    
    func createSequencerVC() -> UIViewController {
        let sequencerVC = MainSequencerViewController(nibName: "MainSequencerViewController", bundle: nil)
        sequencerVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        sequencerVC.setUp(soundEngineManager: soundEngineManager, transportControlsVC: transportControlsVC)
        return sequencerVC
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        transportControlsVC.setUp(soundEngineManager: soundEngineManager)
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createDrumPadHostVC(), createMixerVC(), createSequencerVC()]
        soundEngineManager.createTracks(count: SceneDelegate.trackCount)
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

