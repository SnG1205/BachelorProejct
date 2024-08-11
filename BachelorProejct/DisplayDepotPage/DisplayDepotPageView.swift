//
//  DisplayDepotPageView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 19.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct DisplayDepotPageView: View {
    
    @State private var depotSum: Double = 0
    @Environment(\.dismiss) private var dismiss
    @Query private var stocks: [Stock]
    
    private var clientId: Int
    
    init(clientId: Int){
        self.clientId = clientId
        _stocks = Query(filter: #Predicate<Stock>{stock in stock.clientId == clientId})
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List(stocks){
                    stock in StockItem(stock: stock, index: stocks.firstIndex(where: {$0 == stock})!)
                }
            }
            .navigationTitle("Your Depot")
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}
