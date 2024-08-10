//
//  SellStockPageView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 19.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct SellStockPageView: View {
    
    @State private var amount: String = ""
    @State private var isAlert: Bool = false
    @State private var alertText: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var stocks: [Stock]
    @Query private var balance: [Balance]
    
    private var clientId: Int
    private var symbols: String
    
    init(clientId: Int, symbols: String) {
        self.clientId = clientId
        self.symbols = symbols
        _stocks = Query(filter: #Predicate<Stock>{stock in stock.clientId == clientId && stock.symbols == symbols})
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Text("Enter an amount You want to sell")
                TextField("Amount", text: $amount)
                Button("Sell Stock"){
                    sellStock()
                }
            }
            .navigationTitle("Sell Stock")
            .textFieldStyle(.roundedBorder)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $isAlert){
                Alert(title: Text(alertText),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func sellStock(){
        guard let intAmount = Int(amount) else{
            isAlert = true
            alertText = "Enter an amount first"
            return
        }
        if(stocks[0].amount == intAmount){
            updateBalance(balance: balance[0], updatedBalance: balance[0].balance + stocks[0].price * Double(amount)!)
            modelContext.delete(stocks[0])
            dismiss()
        }
        else if(stocks[0].amount > intAmount){
            updateBalance(balance: balance[0], updatedBalance: balance[0].balance + stocks[0].price * Double(amount)!)
            updateValue(stock: stocks[0], updatedAmount: stocks[0].amount - Int(amount)!)
            dismiss()
        }
        else{
            isAlert = true
            alertText = "Not enough shares to sell"
        }
    }
    
    private func updateValue(stock: Stock, updatedAmount: Int){
        @Bindable var stock: Stock = stock
        stock.amount = updatedAmount
    }
    
    private func updateBalance(balance: Balance, updatedBalance: Double){
        @Bindable var bindableBalance: Balance = balance
        bindableBalance.balance = updatedBalance
    }
}
