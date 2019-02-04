//
//  ViewController.swift
//  Cheats
//
//  Created by Ross Butler on 01/16/2019.
//  Copyright (c) 2019 Ross Butler. All rights reserved.
//

import UIKit
import Cheats
import SVProgressHUD

enum AlertType {
    case success
    case failure
    case info
}

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var cheatStateLabel: UILabel!
    @IBOutlet weak var nextActionLabel: UILabel!

    // MARK: State
    private var gestureRecognizer: CheatCodeGestureRecognizer?

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure SVProgressHUD
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMinimumSize(CGSize(width: 300, height: 200))

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
        self.gestureRecognizer = gestureRecognizer
        actionView.addGestureRecognizer(gestureRecognizer)
    }

    @IBAction func actionPerformed(_ sender: UIGestureRecognizer) {
        print("Gesture recognizer state changed.")
    }

}

// MARK: Cheat Codes
extension ViewController {

    func showAlert(message: String?, type: AlertType = .success) {
        switch type {
        case .info:
            SVProgressHUD.setFont(UIFont.systemFont(ofSize: 32))
            SVProgressHUD.showInfo(withStatus: message)
        case .failure:
            if let retroFont = UIFont(name: "PressStart2P", size: 22.0) {
                SVProgressHUD.setFont(retroFont)
            }
            SVProgressHUD.showError(withStatus: message)
        case .success:
            if let retroFont = UIFont(name: "PressStart2P", size: 22.0) {
                SVProgressHUD.setFont(retroFont)
            }
            SVProgressHUD.showSuccess(withStatus: message)
        }
    }

    /// Update UI to indicate cheat sequence progress
    func updateCheatStateLabel(cheatCode: CheatCode) {
        switch cheatCode.state() {
        case .matched:
            self.cheatStateLabel.text = "Cheat unlocked 🎉"
            showAlert(message: self.cheatStateLabel.text)
        case .matching:
            self.cheatStateLabel.text = "Cheat incomplete"
            showAlert(message: "Correct")
        case .notMatched:
            self.cheatStateLabel.text = "Cheat incorrect 🙅🏻‍♂️"
            showAlert(message: self.cheatStateLabel.text, type: .failure)
        case .reset:
            self.cheatStateLabel.text = "Cheat sequence reset"
        }
    }

    /// Update UI to indicate the next action to be performed in the sequence
    func updateNextActionLabel(cheatCode: CheatCode, delay: Double = 1.0) {
        if let nextAction = cheatCode.nextAction() {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) { [weak self] in
                self?.showAlert(message: nextAction.description, type: .info)
            }
            self.nextActionLabel.text = "Next action: \(nextAction.description)"
        } else {
            self.nextActionLabel.text = ""
        }
    }

}
