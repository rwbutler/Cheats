//
//  CheatCodeActions.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

/// Available actions which can be performed as part of the cheat code sequence.
public enum CheatCodeAction {
    case keyPress(_ key: String)
    case shake
    case swipe(_ direction: CheatCodeSwipeDirection)
    case tap(_ numberOfTaps: UInt)
}

extension CheatCodeAction: Equatable {
    public static func == (lhs: CheatCodeAction, rhs: CheatCodeAction) -> Bool {
        switch(lhs, rhs) {
        case (.keyPress(let lhsKey), .keyPress(let rhsKey)):
            return lhsKey == rhsKey
        case (.swipe(let lhsDirection), .swipe(let rhsDirection)):
            return lhsDirection == rhsDirection
        case (.shake, .shake):
            return true
        case (.tap( let lhsTaps), .tap(let rhsTaps)):
            return lhsTaps == rhsTaps
        default:
            return false
        }
    }
}

extension CheatCodeAction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyPress(let key):
            return "key press: \(key)"
        case .shake:
            return "shake"
        case .swipe(let direction):
            return "swipe \(direction)"
        case .tap(let numberOfTaps):
            switch numberOfTaps {
            case 1:
                return "single tap"
            case 2:
                return "double tap"
            case 3:
                return "triple tap"
            case 4:
                return "quadruple tap"
            default:
                return "tap \(numberOfTaps) times"
            }
        }
    }
}
