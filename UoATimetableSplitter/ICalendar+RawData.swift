//
//  ICalendar+RawData.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import iCalendarParser
import Foundation

extension ICalendar {
    static let iso8601FormatStyle = Date.ISO8601FormatStyle(
        dateSeparator: .omitted,
        dateTimeSeparator: .standard,
        timeSeparator: .omitted,
        timeZoneSeparator: .omitted,
        includingFractionalSeconds: false,
        timeZone: .gmt
    )
    
    var rawData: String {
        var rawData = """
        BEGIN:VCALENDAR
        VERSION: 2.0
        PRODID://Split Calendar//
        """
        
        for event in self.events {
            guard let start = event.dtStart, let end = event.dtEnd else {
                continue
            }
            
            guard let summary = event.summary else { continue }
            
            let startFormatted = start.date
                    .ISO8601Format(ICalendar.iso8601FormatStyle)
            let endFormatted = end.date
                    .ISO8601Format(ICalendar.iso8601FormatStyle)
            
            rawData.appendLine("""
            BEGIN:VEVENT
            DTSTART:\(startFormatted)
            DTEND:\(endFormatted)
            SUMMARY:\(summary)
            """)
            
            if var description = event.description {
                description = description
                        .replacingOccurrences(of: "\\n", with: "\n")
                
                let descriptionLines: [String] = description
                        .split(whereSeparator: \.isNewline).map { String($0) }
                
                let prefix = "Location Name: "
                let location: String? = descriptionLines
                        .filter { $0.hasPrefix(prefix) }
                        .first?
                        .removingPrefix(prefix)
                
                if let location {
                    rawData.appendLine("LOCATION:\(location)")
                }
            }
            
            rawData.appendLine("END:VEVENT")
        }
        
        rawData.appendLine("END:VCALENDAR")
        return rawData
    }
}
