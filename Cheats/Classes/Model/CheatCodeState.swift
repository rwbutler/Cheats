//
//  CheatCodeState.swift
//  Cheats
//
//  Created by Ross Butler on 1/16/19.
//

import Foundation

public enum CheatCodeState {
    /// Cheat code sequence has been performed correctly.
    case matched

    /// Cheat code sequence has been performed correctly so far with further actions required to complete the sequence.
    case matching

    /// Cheat code sequence has been performed incorrectly.
    case notMatched

    /// Cheat code at the beginning / reset - no recognized actions have been performed.
    case reset
}

extension CheatCodeState: Equatable {
    public static func == (lhs: CheatCodeState, rhs: CheatCodeState) -> Bool {
        switch(lhs, rhs) {
        case (.matched, .matched), (.matching, .matching), (.notMatched, .notMatched), (.reset, .reset):
            return true
        default:
            return false
        }
    }
}

extension CheatCodeState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .matched:
            return "matched"
        case .matching:
            return "matching"
        case .notMatched:
            return "not matched"
        case .reset:
            return "reset"
        }
    }
}
