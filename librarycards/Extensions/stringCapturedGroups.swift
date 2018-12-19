//
//  stringCapturedGroups.swift
//  librarycards
//
//  Created by Jasmin Silva on 12/16/18.
//  Copyright © 2018 Jasmin Silva. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //This fuction will parse through the encrypted ID track data and use
    //regular expressions to sort the data into the correct fields
    func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        guard let match = matches.first else { return results }
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        return results
    }
}
