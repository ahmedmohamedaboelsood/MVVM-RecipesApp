//
//  HomeVC.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 21/08/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        tableView.register(UINib(nibName: HomeTableViewCell.ID, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }
}


extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.ID) as! HomeTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


//func extractNumbersManuallyFromString(_ input: String) -> [Int] {
//    var currentNumber = ""
//    var numbers: [Int] = []
//
//    for char in input {
//        if char.isNumber {
//            currentNumber.append(char)
//        } else if !currentNumber.isEmpty {
//            if let number = Int(currentNumber) {
//                numbers.append(number)
//            }
//            currentNumber = ""
//        }
//    }
//
//    if !currentNumber.isEmpty, let number = Int(currentNumber) {
//        numbers.append(number)
//    }
//
//    return numbers
//}
//
//let inputString = "Hello123 World456 Test789"
//let numbers = extractNumbersManuallyFromString(inputString)
//print(numbers)  // Output: [123, 456, 789]
