//
//  ClientItem.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 18.05.24.
//

import Foundation
import SwiftUI

struct ClientItem: View {
    
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack{
            Text(String(user.clientId!))
            Text(user.firstName)
            Text(user.lastName)
            Text(user.address!)
        }
        .navigationTitle("List of Clients")
        .navigationBarTitleDisplayMode(.large)
    }
}
