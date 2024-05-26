//
//  Toast.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 19.05.24.
//

import Foundation

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}
