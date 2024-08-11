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
    @State private var clientIdHolder: String = ""
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
                    .font(.system(size: 20))
                    .padding([.top], 30)
                TextField("Client id", text: $clientId)
                    .frame(width: 100)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 15, trailing: 0))
                    .autocorrectionDisabled(true)
                Button("Buy Stock"){
                    if(checkName(clientId: clientId)){
                        isShowingBuySheet = true
                        clientIdHolder = clientId
                        clientId = ""
                    }
                    else{
                        isAlert = true
                        alertText = "No user found with such id"
                    }
                }
                .padding([.top, .bottom], 15)
                .font(.system(size: 22))
                Button("Get Balance", action: {
                    isAlert = true
                    alertText = String(format: "%.2f", balance.first!.balance)
                })
                .font(.system(size: 22))
                .padding([.top, .bottom], 15)
                Button("Create Client", action: {
                    isShowingCreateSheet = true
                    clientId = ""
                })
                .padding([.top, .bottom], 15)
                .font(.system(size: 22))
                NavigationLink(destination: DisplayClientsPageView()){
                    Text("Display Clients")
                }
                .onDisappear(){
                    clientId = ""
                }
                .padding([.top, .bottom], 15)
                .font(.system(size: 22))
                Button("Display Depot", action: {
                    if(checkName(clientId: clientId)){
                        isShowingDepotSheet = true
                        clientIdHolder = clientId
                        clientId = ""
                    }
                    else{
                        isAlert = true
                        alertText = "No user found with such id"
                    }
                })
                .padding([.top, .bottom], 15)
                .font(.system(size: 22))
                Spacer()
            }
            .sheet(isPresented: $isShowingBuySheet){ BuyStockPageView(clientId: Int(clientIdHolder)!)}
            .sheet(isPresented: $isShowingCreateSheet){CreateClientView()}
            .sheet(isPresented: $isShowingDepotSheet){ DisplayDepotPageView(clientId: Int(clientIdHolder)!)}
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
        return false
    }
}
