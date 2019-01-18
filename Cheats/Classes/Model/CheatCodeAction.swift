//
//  CheatCodeActions.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

/// Available actions which can be performed as part of the cheat code sequence.
public enum CheatCodeAction {
    case shake
    case swipe(_ direction: CheatCodeSwipeDirection)
    case keyPress(_ key: String)
}

extension CheatCodeAction: Equatable {
    public static func == (lhs: CheatCodeAction, rhs: CheatCodeAction) -> Bool {
        switch(lhs, rhs) {
        case (.swipe(let lhsDirection), .swipe(let rhsDirection)):
            return lhsDirection == rhsDirection
        case (.keyPress(let lhsKey), .keyPress(let rhsKey)):
            return lhsKey == rhsKey
        case (.shake, .shake):
            return true
        default:
            return false
        }
    }
}

extension CheatCodeAction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .shake:
            return "shake"
        case .swipe(let direction):
            return "swipe \(direction)"
        case .keyPress(let key):
            return "key press: \(key)"
        }
    }
}
