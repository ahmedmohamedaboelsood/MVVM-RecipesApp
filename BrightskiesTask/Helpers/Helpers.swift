//
//  Helpers.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 23/08/2023.
//

import UIKit

func extractNumbersManuallyFromString(_ input: String) -> [Int] {
    var currentNumber = ""
    var numbers: [Int] = []
    
    for char in input {
        if char.isNumber {
            currentNumber.append(char)
        } else if !currentNumber.isEmpty {
            if let number = Int(currentNumber) {
                numbers.append(number)
            }
            currentNumber = ""
        }
    }
    if !currentNumber.isEmpty, let number = Int(currentNumber) {
        numbers.append(number)
    }
    return numbers
}
