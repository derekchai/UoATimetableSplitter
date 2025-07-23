//
//  TimetableSplitter.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import Foundation
import iCalendarParser

class TimetableSplitter {
    private let calendar: ICalendar
    
    init(filePath: String) throws {
        let url = URL(filePath: filePath)
        let filename = url.lastPathComponent
        
        let rawData = try String(contentsOf: url, encoding: .utf8)
        
        guard let calendar = ICParser().calendar(from: rawData) else {
            throw TimetableSplitterError.unableToParseICS(filename)
        }
        
        self.calendar = calendar
    }
    
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
