//
//  ViewController.swift
//  Cheats
//
//  Created by Ross Butler on 01/16/2019.
//  Copyright (c) 2019 rwbutler. All rights reserved.
//

import UIKit
import Cheats

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var cheatStateLabel: UILabel!
    @IBOutlet weak var nextActionLabel: UILabel!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Define the cheat code as a sequence of actions
        let actionSequence: [CheatCode.Action] = [.swipe(.up), .swipe(.down), .swipe(.left),
                                                  .swipe(.right), .keyPress("a"), .keyPress("b")]

        // Update the UI as the cheat code sequence progresses
        let cheatCode = CheatCode(actions: actionSequence) { [weak self] cheatCode in
            self?.updateCheatStateLabel(cheatCode: cheatCode)
            self?.updateNextActionLabel(cheatCode: cheatCode)
        }

        // Update the label indicating the action to be performed next by the user
        updateNextActionLabel(cheatCode: cheatCode)

        // Add the gesture recognizer
        let gestureRecognizer = CheatCodeGestureRecognizer(cheatCode: cheatCode, target: self,
                                                           action: #selector(actionPerformed(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @IBAction func actionPerformed(_ sender: UIGestureRecognizer) {
        print("Gesture recognizer state changed.")
    }

}

// MARK: Cheat Codes
extension ViewController {

    /// Reset the UI after cheat code correct / incorrect
    func reset(cheatCode: CheatCode) {
        let deadline = DispatchTime.now() + 2.0
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            cheatCode.reset()
            self.cheatStateLabel.text = "Cheat sequence reset"
            self.updateNextActionLabel(cheatCode: cheatCode)
        }
    }

    /// Update UI to indicate cheat sequence progress
    func updateCheatStateLabel(cheatCode: CheatCode) {
        switch cheatCode.state() {
        case .matched:
            self.cheatStateLabel.text = "Cheat unlocked!"
            self.reset(cheatCode: cheatCode)
        case .matching:
            self.cheatStateLabel.text = "Cheat incomplete"
        case .notMatched:
            self.cheatStateLabel.text = "Cheat incorrect"
            self.reset(cheatCode: cheatCode)
        }
    }

    /// Update UI to indicate the next action to be performed in the sequence
    func updateNextActionLabel(cheatCode: CheatCode) {
        if let nextAction = cheatCode.nextAction() {
            self.nextActionLabel.text = "Next action: \(nextAction.description)"
        } else {
            self.nextActionLabel.text = ""
        }
    }

}
