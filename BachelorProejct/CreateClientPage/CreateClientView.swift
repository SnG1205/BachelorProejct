//
//  CreateClientView.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation
import SwiftData
import SwiftUI

struct CreateClientView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var address: String = ""
    
    @AppStorage("clientId") private var id = 1
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Address", text: $address)
            }
            .navigationTitle("User Creation")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Save"){
                        modelContext.insert(User(clientId: id, firstName: firstName, lastName: lastName, address: address, isEmployee: false))
                        id += 1
                        dismiss()
                    }
                }
            }
        }
    }
}
