//
//  StockItem.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 19.05.24.
//

import Foundation
import SwiftUI

struct StockItem: View {
    
    @State private var isShowingSellSheet: Bool = false
    
    private var stock: Stock
    private var index: Int
    
    init(stock: Stock, index: Int) {
        self.stock = stock
        self.index = index + 1
    }
    
    var body: some View {
        HStack{
            Text(String(index))
            Text(stock.symbols)
            Text(String(stock.amount))
            Text(String(stock.price))
        }
        .onTapGesture {
            isShowingSellSheet = true
        }
        .sheet(isPresented: $isShowingSellSheet) {SellStockPageView(clientId: stock.clientId, symbols: stock.symbols)}
    }
}
