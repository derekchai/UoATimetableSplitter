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
    
    @Option(name: .shortAndLong,
            help: "The path to the output directory for the split .ics files.")
    var outputPath: String? = nil
    
    mutating func run() throws {
        let splitter = try TimetableSplitter(filePath: filePath)
        
        for (count, calendar) in splitter.havingBeenSplit().enumerated() {
            let currentDirectory = FileManager().currentDirectoryPath
            let outputPath: String = self.outputPath ?? currentDirectory
            
            let outputURL = URL(fileURLWithPath: outputPath)
                .appending(component: "\(count + 1).ics")
            
            try calendar.rawData
                .write(to: outputURL, atomically: true, encoding: .utf8)
        }
    }
}
