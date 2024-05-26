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
    private var lastName: String
    
    @State private var isShowingBuySheet: Bool = false
    @State private var isShowingDepotSheet: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var users: [User]
    
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
        _users = Query(filter: #Predicate<User>{user in user.firstName == firstName})
    }
    
    var body: some View {
        VStack(spacing: 30){
                Text("Choose one of the options below")
                Button("Buy Stock", action: {
                    isShowingBuySheet = true
                })
                Button("Display Depot", action: {
                    isShowingDepotSheet = true
                })
                Text(users[0].firstName)
                Text(String(users.count))
            }
        .sheet(isPresented: $isShowingBuySheet){ BuyStockPageView(clientId: users[0].clientId!)}
        .sheet(isPresented: $isShowingDepotSheet){ DisplayDepotPageView(clientId: users[0].clientId!)}
    }
    
    static func predicate(firstName: String) -> Predicate<User>{
        return #Predicate<User>{user in user.firstName == firstName}
    }
}
