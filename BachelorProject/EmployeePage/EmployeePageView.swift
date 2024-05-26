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
    @State private var toast: Toast? = nil
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
                    isShowingBuySheet = checkName(clientId: clientId)
                    //Todo add toast if false
                }
                Button("Get Balance", action: {
                    toast = Toast(style: .success, message: "wohooo")
                })
                Button("Create Client", action: {
                    isShowingCreateSheet = true
                })
                NavigationLink(destination: DisplayClientsPageView()){
                    Text("Display Clients")
                }
                Button("Display Depot", action: {
                   isShowingDepotSheet = checkName(clientId: clientId)
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
            .onAppear(perform: {
                if(balance.isEmpty){
                    modelContext.insert(Balance(balance: 1000000))
                }
            })
            .toastView(toast: $toast)
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
