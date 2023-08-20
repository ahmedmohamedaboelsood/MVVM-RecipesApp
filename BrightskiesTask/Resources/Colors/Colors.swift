//
//  Colors.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 20/08/2023.
//


import Foundation
import UIKit

enum AppColors {
    case green
}

extension AppColors{
    var color : UIColor {
        switch self{
        case .green:
            return UIColor(named: "ThemeColor") ?? UIColor.red
        }
    }
}
