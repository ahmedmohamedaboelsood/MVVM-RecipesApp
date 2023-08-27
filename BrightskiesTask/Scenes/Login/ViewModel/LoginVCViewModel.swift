//
//  LoginVCViewModel.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 21/08/2023.
//

import Foundation

protocol LoginVCViewModelDelegate {
    func loginIsDone(_ message:String)
    func loginIsFail(_ message:String)
}

class LoginVCViewModel {
    //MARK: - Variables
    private var email = "a@gmail.com"
    private var password = "12345678"
    private var validationState : String?
    var isLoading : Observable<Bool> = Observable(false)
    var delegate : LoginVCViewModelDelegate?
    //MARK: - Functions
    private func validate (_ email:String?, _ password:String?){
        validationState = nil
        guard let email = email, !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationState = "Please enter email"
            return
        }
        guard let password = password, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationState = "Please enter password"
            return
        }
        if isValidEmail(email){
            if password.count<8{
                delegate?.loginIsFail("Password Should be 8 letters or more")
            }else{
                isLoading.value = true
                login(email, password)
            }
        }else{
            delegate?.loginIsFail("Wrong email format")
        }
    }
    
    private func isValidEmail(_ email: String)->Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func login(_ email : String ,_ password : String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [weak self] in
            guard let self = self else {return}
            isLoading.value = false
            if self.email == email && self.password == password{
                delegate?.loginIsDone("Logged successfully")
                UserDefaults.standard.setValue(email, forKey: "userEmail")
                UserDefaults.standard.setValue(password, forKey: "userPassword")
            }else{
                delegate?.loginIsFail("Invalid email or password")
            }
        }
    }
    
    func loginwWithValidation(_ email: String?, _ password : String?)->String?{
        validate(email, password)
        guard let emptyField = validationState else {return nil}
        return emptyField
    }
}
