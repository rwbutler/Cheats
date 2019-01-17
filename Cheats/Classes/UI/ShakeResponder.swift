//
//  ShakeResponder.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

class ShakeResponder: UIControl {

    /// For retrieval of state information
    weak var associatedGestureRecogizer: CheatCodeGestureRecognizer?

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let cheatCode = associatedGestureRecogizer?.cheatCode else { return }
        if motion == .motionShake {
            cheatCode.performed(.shake)
            associatedGestureRecogizer?.configureForNextAction()
        }
    }

}
