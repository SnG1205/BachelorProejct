//
//  EmployeePageView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct EmployeePageView: View {
    
    @State private var clientId: String = ""
    @State private var isShowingCreateSheet: Bool = false
    @State private var isShowingBuySheet: Bool = false
    @State private var isShowingDepotSheet: Bool = false
    @State private var isAlert: Bool = false
    @State private var alertText: String = ""
    @Environment(\.modelContext) private var modelContext
    @Query private var balance: [Balance]
    @Query(sort: \User.clientId) var users: [User]
    
    private var firstName: String
    
    init(firstName: String) {
        self.firstName = firstName
    }
    
    var body: some View {
        //NavigationStack{
            VStack{
                Text("Choose one of the options below")
                TextField("Client id", text: $clientId)
                //Spacer()
                //NavigationLink(value: "buy", label: {Text("Buy Stock")})
                Button("Buy Stock"){
                    if(checkName(clientId: clientId)){
                        isShowingBuySheet = true
                    }
                    else{
                        isAlert = true
                        alertText = "No user found with such id"
                    }
                }
                Button("Get Balance", action: {
                    isAlert = true
                    alertText = String(format: "%.2f", balance.first!.balance)
                    //Todo display alert
                })
                Button("Create Client", action: {
                    isShowingCreateSheet = true
                })
                NavigationLink(destination: DisplayClientsPageView()){
                    Text("Display Clients")
                }
                Button("Display Depot", action: {
                    if(checkName(clientId: clientId)){
                        isShowingDepotSheet = true
                    }
                    else{
                        isAlert = true
                        alertText = "No user found with such id"
                    }
                })
                Text(firstName)
                Text(String(users[0].clientId!))
                Text(String(balance[0].balance))
            }
            .sheet(isPresented: $isShowingBuySheet){ BuyStockPageView(clientId: Int(clientId)!)}
            .sheet(isPresented: $isShowingCreateSheet){CreateClientView()}
            .sheet(isPresented: $isShowingDepotSheet){ DisplayDepotPageView(clientId: Int(clientId)!)}
            .textFieldStyle(.roundedBorder)
            .navigationTitle("Welcome, \(firstName)")
            .alert(isPresented: $isAlert){
                Alert(title: Text(alertText),
                      dismissButton: .default(Text("OK")))
            }
            .onAppear(perform: {
            })
        //}
    }
    
    private func checkName(clientId: String) -> Bool{
        for user in users{
            if(user.clientId == Int(clientId)){
                return true
            }
        }
        return false //Todo add showsnackbar here mb
    }
}
