//
//  Item.swift
//  kbWriter
//
//  Created by Graham Hall on 10/16/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
