//
//  String+Extensions.swift
//  UoATimetableSplitter
//
//  Created by Derek Chai on 24/07/2025.
//

import Foundation

extension String {
    /// Appends the given string to this string on a new line.
    /// - Parameter line: The string to append on a new line.
    mutating func appendLine(_ line: String) {
        self.append("\n\(line)")
    }
    
    /// Removes the prefix `prefix` from this string.
    /// - Parameter prefix: The prefix to remove.
    /// - Returns: The string without the prefix.
    func removingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
