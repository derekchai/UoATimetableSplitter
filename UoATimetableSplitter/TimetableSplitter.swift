//
//  TimetableSplitter.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import Foundation
import iCalendarParser

class TimetableSplitter {
    /// The main calendar (not split) associated with this
    /// ``TimetableSplitter``.
    private let calendar: ICalendar
    
    /// Initializes a new ``TimetableSplitter`` from the `ics` file located at
    /// `filePath`.
    /// - Parameter filePath: The path to the `ics` file to open.
    /// - Throws: ``TimetableSplitterError.unableToParseICS`` if the file could
    /// not be parsed as an `ics` file. Rethrows any errors thrown by
    /// `String(contentsOf:encoding:)` when opening the file at `filePath`
    /// for reading.
    init(filePath: String) throws {
        let url = URL(filePath: filePath)
        let filename = url.lastPathComponent
        
        let rawData = try String(contentsOf: url, encoding: .utf8)
        
        guard let calendar = ICParser().calendar(from: rawData) else {
            throw TimetableSplitterError.unableToParseICS(filename)
        }
        
        self.calendar = calendar
    }
    
    /// Returns an array of tuples, where each element contains the subject
    /// (course code) of the split calendar, and the split calendar itself.
    func havingBeenSplit() -> [(String, ICalendar)] {
        var splitCalendars: [(String, ICalendar)] = []
        
        let groupedEvents = Dictionary(
            grouping: calendar.events,
            by: { $0.summary?.components(separatedBy: "/").first }
        )
        
        for subject in groupedEvents.keys {
            guard let subject else { continue }
            
            let calendar = ICalendar(
                events: groupedEvents[subject] ?? [],
                productId: ICProductIdentifier("Split Calendar")
            )
            
            splitCalendars.append((subject, calendar))
        }
        
        return splitCalendars
    }
}
