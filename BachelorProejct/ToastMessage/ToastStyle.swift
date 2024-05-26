//
//  ToastFile.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 19.05.24.
//

import Foundation
import SwiftUI

enum ToastStyle {
  case error
  case success
}

extension ToastStyle {
  var themeColor: Color {
    switch self {
    case .error: return Color.red
    case .success: return Color.green
    }
  }
  
  var iconFileName: String {
    switch self {
    case .success: return "checkmark.circle.fill"
    case .error: return "xmark.circle.fill"
    }
  }
}
