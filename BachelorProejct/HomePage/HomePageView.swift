//
//  File.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 14.05.24.
//

import Foundation
import SwiftUI
import SwiftData

struct HomePageView: View {
    
    @State private var homePageViewModel = HomePageViewModel()
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var bol : Bool? = nil
    @State private var stackPath: [Bool] = []
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @AppStorage("clientId") private var id = 1
    
    var body: some View {
        NavigationStack(path: $stackPath){
            VStack{
                Text("Please enter Your name below.")
                TextField("First name", text: $firstName)
                    .onSubmit {
                    }
                TextField("Last name", text: $lastName)
                    .onSubmit {
                    }
                /*NavigationLink(value: checkName(firstName: firstName, lastName: lastName)){
                 Text("Log In")
                 }*/
                Button("Log In", action: {
                    bol = checkName(firstName: firstName, lastName: lastName)
                    if(bol != nil){
                        stackPath.append(bol!)
                    }
                })
                if (bol != nil && bol!) {
                    Text("Employee")
                }
                if (bol != nil && !bol!) {
                    Text("Client")
                }
                Button("Delete"){
                    Task{
                        try modelContext.delete(model: User.self, where: #Predicate<User>{user in user.firstName == "Daria"})
                    }
                    //Text(users[0].firstName + users[0].lastName)
                }
            }
                .textFieldStyle(.roundedBorder)
                .navigationDestination(for: Bool.self, destination: { bool in
                    if(bool){
                        //Text("Why does this work and other doesn`t")
                        EmployeePageView(firstName: firstName)
                    }
                    else{
                        ClientPageView(firstName: firstName, lastName: lastName)
                    }
                })
                .navigationDestination(for: String.self, destination: {string in
                    if(string == "buy"){
                        //BuyStockPageView()
                    }
                })
            }
            .onAppear(perform: {
                if(users.isEmpty){
                    modelContext.insert(User(clientId: id, firstName: "Serhii", lastName: "Holiev", isEmployee: true))
                    id += 1
                }
            })
        }
        
        
        private func checkName(firstName: String, lastName: String) -> Bool?{
            for user in users{
                if(user.firstName == firstName && user.lastName == lastName){
                    return user.isEmployee            }
            }
            //Todo add showsnackbar here mb
            return nil
        }
    }


