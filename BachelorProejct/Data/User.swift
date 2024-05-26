//
//  User.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 15.05.24.
//

import Foundation
import SwiftData

@Model
final class User{
    var clientId: Int?
    var firstName: String
    var lastName: String
    var address: String? = ""
    var isEmployee: Bool
    
    init(clientId: Int, firstName: String, lastName: String, address: String? = "", isEmployee: Bool) {
        self.clientId = clientId
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.isEmployee = isEmployee
    }
}
