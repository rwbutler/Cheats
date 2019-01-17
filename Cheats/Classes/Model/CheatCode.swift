//
//  CheatCodeState.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

/// State machine implementation of a cheat code sequence.
public class CheatCode {

    public typealias Action = CheatCodeAction
    public typealias State = CheatCodeState

    /// Actions to be performed to complete cheat code sequence.
    private let actions: [CheatCodeAction]

    /// Callback for informing observers of completion progress as actions are performed.
    private let onStateChanged: ((CheatCode) -> Void)?

    /// Actions that have been performed by the user up until this point.
    private var performed: [CheatCodeAction]

    public init(actions: [CheatCodeAction], onStateChanged: ((CheatCode) -> Void)? = nil) {
        self.actions = actions
        self.onStateChanged = onStateChanged
        self.performed = []
    }

    /// The next action to be performed in the cheat code sequence where the sequence has not yet been matched.
    public func nextAction() -> Action? {
        guard state() == .matching || state() == .reset else { return nil }
        if actions.count > performed.count {
            let nextAction = actions[performed.count]
            return nextAction
        }
        return nil
    }

    /// Adds an action to the sequence of actions the user has performed so far.
    public func performed(_ action: CheatCodeAction) {
        performed.append(action)
        unowned let unownedSelf = self
        onStateChanged?(unownedSelf)
    }

    public func previousAction() -> Action? {
        return performed.last
    }

    /// Resets the sequence of actions of performed to allow the user to try again.
    public func reset() {
        self.performed = []
        unowned let unownedSelf = self
        onStateChanged?(unownedSelf)
    }

    /// Determines whether or not the cheat code has been matched by the performed actions,
    /// is matching so far or does not match the required actions.
    /// returns: State of cheat code progress so far.
    public func state() -> State {
        var result: State = .matching
        if performed.isEmpty {
            result = .reset
        }
        for counter in 0..<actions.count {
            let action = actions[counter]
            if counter < performed.count {
                let performedAction = performed[counter]
                if action == performedAction { continue }
                result = .notMatched
                break
            }
        }
        if result == .matching, actions.count <= performed.count {
            return .matched
        }
        return result
    }

}
