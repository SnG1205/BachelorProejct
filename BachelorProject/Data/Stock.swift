//
//  Stock.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation
import SwiftData

@Model
final class Stock{
    var id: UUID
    var clientId: Int
    var symbols: String
    var price: Double
    var amount: Int
    
    init(id: UUID, clientId: Int, symbols: String, price: Double, amount: Int) {
        self.id = id
        self.clientId = clientId
        self.symbols = symbols
        self.price = price
        self.amount = amount
    }
}
