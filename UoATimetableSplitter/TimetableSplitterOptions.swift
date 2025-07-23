//
//  TimetableSplitterOptions.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import Foundation
import ArgumentParser

@main
struct TimetableSplitterOptions: ParsableCommand {
    /// The path to the .ics file to be split.
    @Argument(help: "The path to the .ics file to be split.")
    var filePath: String
    
    mutating func run() throws {
        let splitter = try TimetableSplitter(filePath: filePath)
    }
}
