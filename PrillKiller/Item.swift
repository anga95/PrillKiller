//
//  Item.swift
//  PrillKiller
//
//  Created by AnGa on 2024-10-07.
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
