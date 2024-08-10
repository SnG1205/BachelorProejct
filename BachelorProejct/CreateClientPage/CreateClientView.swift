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
    @State private var isAlert: Bool = false
    @State private var alertText: String = ""
    
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
                        createUser()
                    }
                }
            }
            .alert(isPresented: $isAlert){
                Alert(title: Text(alertText),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func createUser(){ //I have no idea whether passing variables as parameters is needed since they are not being modified or updated here in any way
        if(firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
           || lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
           || address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            isAlert = true
            alertText = "Fields can't be empty"
        } else{
            modelContext.insert(User(clientId: id, firstName: firstName, lastName: lastName, address: address, isEmployee: false))
            id += 1
            dismiss()
        }
    }
}
