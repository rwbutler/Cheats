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
    internal var responder: KeyboardResponder? = nil
    
    public init(cheatCode: CheatCode, target: Any?, action: Selector?) {
        self.cheatCode = cheatCode
        super.init(target: target, action: action)
    }
    
    private func showKeyboard() {
        if responder == nil {
            responder = KeyboardResponder()
            responder?.associatedGestureRecogizer = self
        }
        guard let responder = responder else { return }
        if responder.superview == nil {
            view?.addSubview(responder)
        }
        responder.becomeFirstResponder()
    }
    
    override public func reset() {
        super.reset()
        cheatCode?.reset()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard touches.count == 1 else { // We only support swipes currently.
            state = .failed
            return
        }
        previousTouchPoint = touches.first!.location(in: view)
        state = .began
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        let touch = touches.first!.location(in: view)
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
        
        switch cheatCode?.nextAction() {
        case .some(.keyPress):
            showKeyboard()
        default:
            break
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    }
}
