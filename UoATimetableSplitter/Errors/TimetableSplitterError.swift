//
//  TimetableSplitterError.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import Foundation

enum TimetableSplitterError: Error {
    case unableToParseICS(String)
}

extension TimetableSplitterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToParseICS(let filename):
            return "The file \"\(filename)\" could not be parsed as an .ics file."
        }
    }
}
