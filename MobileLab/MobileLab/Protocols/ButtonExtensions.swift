//
//  ButtonExtensions.swift
//  MobileLab
//
//  Created by Jerry on 1/16/22.
//

import Foundation
import UIKit

let muteImage = UIImage(systemName: "speaker.slash.fill")?.withRenderingMode(.alwaysOriginal)
let speakerFillImage = UIImage(systemName: "speaker.wave.2.fill")?.withRenderingMode(.alwaysOriginal)

extension UIButton {
    func setMuteButtonImage(track: Int, bool: Bool){
        if bool {
            self.setImage(muteImage, for: .normal)
        }
        else {
            self.setImage(speakerFillImage, for: .normal)
        }
    }
}
