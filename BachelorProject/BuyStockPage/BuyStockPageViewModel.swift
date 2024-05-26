//
//  BuyStockPageViewModel.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 19.05.24.
//

import Foundation
import SwiftData
import SwiftUI

class BuyStockPageViewModel: ObservableObject{
    
    @Environment(\.modelContext) private var modelContext
    
    @Published var symbols: String = ""
    
    @Query var some: [Stock]
    
    init(symbols: String) {
        self.symbols = symbols
        _some = Query(filter: #Predicate<Stock>{stock in stock.symbols == symbols})
    }
}
