//
//  Balance.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 16.05.24.
//

import Foundation
import SwiftData

@Model
final class Balance{
    var balance: Double
    
    init(balance: Double){
        self.balance = balance
    }
}
