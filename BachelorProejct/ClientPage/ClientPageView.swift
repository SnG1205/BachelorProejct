//
//  ClientPageView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct ClientPageView: View {
    
    private var firstName: String
    
    @State private var isShowingBuySheet: Bool = false
    @State private var isShowingDepotSheet: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var users: [User]
    
    init(firstName: String){
        self.firstName = firstName
        _users = Query(filter: #Predicate<User>{user in user.firstName == firstName})
    }
    
    var body: some View {
        VStack(spacing: 30){
                Text("Choose one of the options below")
                .font(.system(size: 20))
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                Button("Buy Stock", action: {
                    isShowingBuySheet = true
                })
                .font(.system(size: 24))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Button("Display Depot", action: {
                    isShowingDepotSheet = true
                })
                .font(.system(size: 24))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
        .navigationTitle("Welcome, \(firstName)")
        .sheet(isPresented: $isShowingBuySheet){ BuyStockPageView(clientId: users[0].clientId!)}
        .sheet(isPresented: $isShowingDepotSheet){ DisplayDepotPageView(clientId: users[0].clientId!)}
    }
    
    /*static func predicate(firstName: String) -> Predicate<User>{
        return #Predicate<User>{user in user.firstName == firstName}
    }*/
}
