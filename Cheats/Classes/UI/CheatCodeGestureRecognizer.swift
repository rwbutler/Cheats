//
//  CheatCodeRecognizer.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation
import UIKit

public class CheatCodeGestureRecognizer: UIGestureRecognizer {
    public let cheatCode: CheatCode?
    public var movementDelta: CGFloat = 50
    private var previousTouchPoint: CGPoint = CGPoint.zero
    private var observation: NSKeyValueObservation?
    internal var keyboardResponder: KeyboardResponder = KeyboardResponder()
    internal var shakeResponder: ShakeResponder = ShakeResponder()

    public init(cheatCode: CheatCode, target: Any?, action: Selector?) {
        self.cheatCode = cheatCode
        super.init(target: target, action: action)
        keyboardResponder.associatedGestureRecogizer = self
        shakeResponder.associatedGestureRecogizer = self
        observation = self.observe(\.view, options: [.new]) { _, _ in
            self.addResponders()
        }
    }

    deinit {
        observation = nil
    }

    private func addKeyboardResponder() {
        if keyboardResponder.superview == nil {
            view?.addSubview(keyboardResponder)
        }
    }

    private func addResponders() {
        addKeyboardResponder()
        addShakeResponder()
        configureForNextAction()
    }

    private func addShakeResponder() {
        if shakeResponder.superview == nil {
            shakeResponder.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            shakeResponder.backgroundColor = UIColor.red
            view?.addSubview(shakeResponder)
            shakeResponder.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        }
    }

    override public func reset() {
        super.reset()
        cheatCode?.reset()
        configureForNextAction()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard touches.count == 1 else { // We only support swipes currently.
            state = .failed
            return
        }
        if let touchPoint = touches.first?.location(in: view) {
            previousTouchPoint = touchPoint
            state = .began
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first?.location(in: view) else { return }
        let deltaX = touch.x - previousTouchPoint.x
        let deltaY = touch.y - previousTouchPoint.y

        if deltaY > movementDelta {
            cheatCode?.performed(.swipe(.down))
        }
        if deltaX < -movementDelta {
            cheatCode?.performed(.swipe(.left))
        }
        if deltaX > movementDelta {
            cheatCode?.performed(.swipe(.right))
        }
        if deltaY < -movementDelta {
            cheatCode?.performed(.swipe(.up))
        }

        switch cheatCode?.state() {
        case .some(.matched):
            state = .recognized
        case .some(.matching):
            state = .changed
        case .some(.notMatched):
            state = .failed
        default:
            break
        }
        configureForNextAction()
    }

    internal func configureForNextAction() {
        switch cheatCode?.nextAction() {
        case .some(.keyPress):
            keyboardResponder.becomeFirstResponder()
        case .some(.shake):
            shakeResponder.becomeFirstResponder()
        default:
            keyboardResponder.resignFirstResponder()
            shakeResponder.becomeFirstResponder()
        }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    }
}
