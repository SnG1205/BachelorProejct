//
//  DisplayClientsPageView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 18.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct DisplayClientsPageView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    
    var body: some View {
        
        VStack(spacing: 10){
            List(users){
                ClientItem(user: $0)
            }
        }
    }
}
