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
                NavigationLink(destination: BuyStockPageView(clientId: users[0].clientId!)){
                 Text("Buy Stock") //Todo pass an id/name to view
                }
                Button("Display Depot", action: {
                    
                })
                Text(users[0].firstName)
                Text(String(users.count))
            }
    }
    
    static func predicate(firstName: String) -> Predicate<User>{
        return #Predicate<User>{user in user.firstName == firstName}
    }
}
