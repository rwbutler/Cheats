//
//  CheatCodeActions.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

/// Available actions which can be performed as part of the cheat code sequence.
public enum CheatCodeAction {
    case swipe(_ direction: CheatCodeSwipeDirection)
    case keyPress(_ key: String)
}

extension CheatCodeAction: Equatable {
    public static func == (lhs: CheatCodeAction, rhs: CheatCodeAction) -> Bool {
        switch(lhs, rhs) {
        case (.swipe(let a), .swipe(let b)):
            return a == b
        case (.keyPress(let a), .keyPress(let b)):
            return a == b
        default:
            return false
        }
    }
}

extension CheatCodeAction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .swipe(let direction):
            return "swipe \(direction)"
        case .keyPress(let key):
            return "key press: \(key)"
        }
    }
}

