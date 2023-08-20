//
//  UIViewController + Extentions.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 20/08/2023.
//
 
import Foundation
import UIKit

extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showALert(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.modalTransitionStyle = .coverVertical
         self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 ){
            alert.dismiss(animated: true)
        }
    }
    
    func showAlertWithNavigation(massege : String , VC : UIViewController ) {
        let alertController = UIAlertController(title: "Alert", message: massege, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            let vc = VC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
