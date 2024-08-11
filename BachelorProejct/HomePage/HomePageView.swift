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
    
    @State private var firstNameHolder: String = ""
    
    @State private var homePageViewModel = HomePageViewModel()
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var bol : Bool? = nil
    @State private var stackPath: [Bool] = []
    @State private var isAlert: Bool = false
    @State private var alertText: String = ""
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var balance: [Balance]
    @AppStorage("clientId") private var id = 1
    
    var body: some View {
        NavigationStack(path: $stackPath){
            VStack(alignment: .center){
                Text("Please enter Your name below.")
                    .padding(EdgeInsets(top: 40, leading: 10, bottom: 10, trailing: 10))
                    .font(.system(size: 20))
                TextField("First name", text: $firstName)
                    .frame(width: 250)
                    .padding([.bottom, .top], 20)
                    .autocorrectionDisabled(true)
                TextField("Last name", text: $lastName)
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    .autocorrectionDisabled(true)
                Button("Log In"){
                    bol = checkName(firstName: firstName, lastName: lastName)
                    if(bol != nil){
                        stackPath.append(bol!)
                        firstNameHolder = firstName
                        firstName = ""
                        lastName = ""
                    }
                    else{
                        isAlert = true
                        alertText = "User was not found"
                        firstName = ""
                        lastName = ""
                    }
                }
                .frame(width: 70, height: 80)
                .font(.system(size: 24))
                Spacer()
            }
            .navigationBarTitle("Banking App")
            .textFieldStyle(.roundedBorder)
            .navigationDestination(for: Bool.self, destination: { bool in
                if(bool){
                    //Text("Why does this work and other doesn`t")
                    EmployeePageView(firstName: firstNameHolder)
                }
                else{
                    ClientPageView(firstName: firstNameHolder)
                }
            })
            }
            .alert(isPresented: $isAlert){
                Alert(title: Text(alertText),
                      dismissButton: .default(Text("OK")))
            }
            .onAppear(perform: {
                if(users.isEmpty){
                    modelContext.insert(User(clientId: id, firstName: "Serhii", lastName: "Holiev", isEmployee: true))
                    id += 1
                }
                if(balance.isEmpty){
                    modelContext.insert(Balance(balance: 1000000))
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


