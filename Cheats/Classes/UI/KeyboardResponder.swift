//
//  Responder.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation
import UIKit

class KeyboardResponder: UIControl, UIKeyInput, UITextInputTraits {

    /// For retrieval of state information
    weak var associatedGestureRecogizer: CheatCodeGestureRecognizer?

    /// For UIKeyInput conformance
    var hasText: Bool = false

    override var canBecomeFirstResponder: Bool {
        return true
    }

    func deleteBackward() { // Do nothing
    }

    func insertText(_ text: String) {
        guard let cheatCode = associatedGestureRecogizer?.cheatCode else { return }
        cheatCode.performed(.keyPress(text))
        if cheatCode.state() != .matching {
            resignFirstResponder()
        }
        configureForNextAction()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let cheatCode = associatedGestureRecogizer?.cheatCode else { return }
        if motion == .motionShake {
            cheatCode.performed(.shake)
            configureForNextAction()
        }
    }

    private func configureForNextAction() {
        associatedGestureRecogizer?.configureForNextAction()
    }

}
