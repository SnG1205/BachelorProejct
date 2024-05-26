//
//  BuyStockPageView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct BuyStockPageView: View {
    
    @State private var symbols: String = ""
    @State private var amount: String = ""
    @State private var responseText: String = ""
    @State private var apiResponse: ApiResponse?
    @State private var viewModel = BuyStockPageViewModel(symbols: "")
    @State private var toast: Toast? = nil
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var stocks: [Stock]
    @Query private var balance: [Balance]
    
    private var clientId: Int
    
    init(clientId: Int) {
        self.clientId  = clientId
        _stocks = Query(filter: #Predicate<Stock>{stock in stock.clientId == clientId})
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                Text("Enter stock symbols You want to buy")
                TextField("Symbols", text: $symbols)
                Text("Enter amount You want to buy")
                TextField("Amount", text: $amount)
                Text(responseText)
                Button("Get stock", action: {
                    Task{
                        apiResponse = try await fetchStock(symbols: symbols)
                        responseText = "Price of the \(apiResponse!.ticker): \(apiResponse!.results[0].o)"
                    }
                })
                Button("Buy stock", action: {
                    let stockToUpdate = isAcquired(symbols: apiResponse!.ticker)
                    
                    if(stockToUpdate != nil){
                        let totalPrice = Double(amount)! * apiResponse!.results[0].o
                        if(balance[0].balance < totalPrice){
                            //Todo  display toast
                        }
                        else{
                            updateValue(stock: stockToUpdate!, updatedAmount: stockToUpdate!.amount + Int(amount)!, updatedPrice: apiResponse!.results[0].o)
                            updateBalance(balance: balance[0], updatedBalance: balance[0].balance - totalPrice)
                        }
                    }
                    else{
                        let totalPrice = Double(amount)! * apiResponse!.results[0].o
                        if(balance[0].balance < totalPrice){
                            toast = Toast(style: .error, message: "Not enough balance")
                            //Todo  display toast
                        }
                        else{
                            modelContext.insert(Stock(id: UUID(), clientId: clientId, symbols: apiResponse!.ticker, price: apiResponse!.results[0].o, amount: Int(amount)!))
                            updateBalance(balance: balance[0], updatedBalance: balance[0].balance - totalPrice)
                        }
                    }
                    symbols = ""
                    amount = ""
                })
                Text(String(clientId))
            }
            .navigationTitle("Buy Stock")
            .textFieldStyle(.roundedBorder)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .toastView(toast: $toast)
        }
    }
    
    private func fetchStock(symbols: String) async throws -> ApiResponse{
        return try await getStock(symbols: symbols);
    }
    
    private func isAcquired(symbols: String) -> Stock?{
        for stock in stocks {
            if(stock.symbols == symbols){
                return stock
            }
        }
        return nil
    }
    
    private func updateValue(stock: Stock, updatedAmount: Int, updatedPrice: Double){
        @Bindable var bindableStock: Stock = stock
        bindableStock.amount = updatedAmount
        bindableStock.price = updatedPrice
    }
    
    private func updateBalance(balance: Balance, updatedBalance: Double){
        @Bindable var bindableBalance: Balance = balance
        bindableBalance.balance = updatedBalance
    }
}
