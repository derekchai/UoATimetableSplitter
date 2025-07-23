//
//  TimetableSplitter.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import Foundation

class TimetableSplitter {
    /// The raw data of the .ics file as a string.
    private let rawData: String
    
    init(filePath: String) throws {
        let url = URL(filePath: filePath)
        self.rawData = try String(contentsOf: url, encoding: .utf8)
    }
}
