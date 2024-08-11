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
    @State private var isAlert: Bool = false
    @State private var alertText: String = ""
    
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
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 5, trailing: 0))
                TextField("Symbols", text: $symbols)
                    .frame(width: 150)
                    .padding([.bottom], 30)
                    .autocorrectionDisabled(true)
                Text("Enter amount You want to buy")
                    .padding([.bottom], 5)
                TextField("Amount", text: $amount)
                    .frame(width: 150)
                    .padding([.bottom], 20)
                    .autocorrectionDisabled(true)
                Text(responseText)
                    .padding([.bottom], 20)
                Button("Get stock", action: {
                    Task{
                        do {
                            apiResponse = try await fetchStock(symbols: symbols)
                            responseText = "Price of the \(apiResponse!.ticker): \(apiResponse!.results[0].o)"
                        } catch {
                            isAlert = true
                            alertText = "Stocks were not found"
                            symbols = ""
                        }
                    }
                })
                .font(.system(size: 22))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Button("Buy stock", action: {
                    if(apiResponse == nil){
                        isAlert = true
                        alertText = "Search for stocks first"
                    } else{
                        let stockToUpdate = isAcquired(symbols: apiResponse!.ticker)
                        
                        if(stockToUpdate != nil){
                            guard let doubleAmount = Double(amount) else{
                                isAlert = true
                                alertText = "Enter an amount first"
                                amount = ""
                                return
                            }
                            let totalPrice = doubleAmount * apiResponse!.results[0].o
                            if(balance[0].balance < totalPrice){
                                isAlert = true
                                alertText = "Not enough balance to buy this amount"
                                amount = ""
                            }
                            else{
                                updateValue(stock: stockToUpdate!, updatedAmount: stockToUpdate!.amount + Int(amount)!, updatedPrice: apiResponse!.results[0].o)
                                updateBalance(balance: balance[0], updatedBalance: balance[0].balance - totalPrice)
                                isAlert = true
                                alertText = "Shares were bought successfully"
                            }
                        }
                        else{
                            guard let doubleAmount = Double(amount) else{
                                isAlert = true
                                alertText = "Enter an amount first"
                                amount = ""
                                return
                            }
                            let totalPrice = doubleAmount * apiResponse!.results[0].o
                            if(balance[0].balance < totalPrice){
                                isAlert = true
                                alertText = "Not enough balance to buy this amount"
                            }
                            else{
                                modelContext.insert(Stock(id: UUID(), clientId: clientId, symbols: apiResponse!.ticker, price: apiResponse!.results[0].o, amount: Int(amount)!))
                                updateBalance(balance: balance[0], updatedBalance: balance[0].balance - totalPrice)
                                isAlert = true
                                alertText = "Shares were bought successfully"
                            }
                        }
                        symbols = ""
                        amount = ""
                    }
                    
                })
                .font(.system(size: 22))
                Spacer()
            }
            .alert(isPresented: $isAlert){
                Alert(title: Text(alertText),
                      dismissButton: .default(Text("OK")))
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
