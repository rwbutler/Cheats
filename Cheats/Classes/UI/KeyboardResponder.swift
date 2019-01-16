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
    weak var associatedGestureRecogizer: CheatCodeGestureRecognizer? = nil
    var returnKeyType: UIReturnKeyType = .done
    var hasText: Bool = false
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func deleteBackward() {
        // Do nothing
    }
    
    func insertText(_ text: String) {
        guard let cheatCode = associatedGestureRecogizer?.cheatCode else { return }
        cheatCode.performed(.keyPress(text))
        if cheatCode.state() != .matching {
            resignFirstResponder()
            return
        }
        switch cheatCode.nextAction() {
        case .some(.swipe):
            resignFirstResponder()
        default:
            return
        }
    }
    
}
