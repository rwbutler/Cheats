//
//  CheatCodeSwipeDirection.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

public enum CheatCodeSwipeDirection {
    case up
    case down
    case left
    case right
}

extension CheatCodeSwipeDirection: Equatable {
    public static func == (lhs: CheatCodeSwipeDirection, rhs: CheatCodeSwipeDirection) -> Bool {
        switch(lhs, rhs) {
        case (.up, .up), (.down, .down), (.left, .left), (.right, .right):
            return true
        default:
            return false
        }
    }
}

extension CheatCodeSwipeDirection: CustomStringConvertible {
    public var description: String {
        switch self {
        case .up:
            return "up"
        case .down:
            return "down"
        case .left:
            return "left"
        case .right:
            return "right"
        }
    }
}
