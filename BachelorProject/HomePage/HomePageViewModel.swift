//
//  HomePageViewModel.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 15.05.24.
//

import Foundation

class HomePageViewModel: ObservableObject{
    @Published var username: String = ""
    @Published var lastName: String = ""
    @Published var isHidden: Bool = true
    @Published var stackPaths: [String] = []
    
    init(isHidden : Bool? = true) {
        self.isHidden = isHidden!
    }
}
