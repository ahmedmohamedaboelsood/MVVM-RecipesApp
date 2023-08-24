//
//  LoginVC.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 20/08/2023.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTitleLbl: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var passwordTxField: UITextField!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBOutlet weak var emailTitleLbl: UILabel!
    @IBOutlet weak var passwordTextFieldContainer: UIView!
    @IBOutlet weak var emailtextFieldContainer: UIView!
    @IBOutlet weak var loginFormContainerView: UIView!
    //MARK: - Variables
    var viewModel = LoginVCViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - Functions
    private func setupUI(){
        navigationItem.hidesBackButton = true
        activityIndicator.stopAnimating()
        viewModel.delegate = self
        hideKeyboardWhenTappedAround()
        loginFormContainerView.layer.cornerRadius = 30
        emailtextFieldContainer.layer.borderColor = AppColors.green.color.cgColor
        emailtextFieldContainer.layer.borderWidth = 1
        emailtextFieldContainer.layer.cornerRadius = emailtextFieldContainer.bounds.height / 2
        passwordTextFieldContainer.layer.borderColor = AppColors.green.color.cgColor
        passwordTextFieldContainer.layer.borderWidth = 1
        passwordTextFieldContainer.layer.cornerRadius = emailtextFieldContainer.bounds.height / 2
        loginBtnOutlet.layer.borderColor = UIColor.darkGray.cgColor
        loginBtnOutlet.layer.borderWidth = 1
        loginBtnOutlet.layer.cornerRadius = loginBtnOutlet.bounds.height / 2
    }
    
    private func bindViewModel(){
        viewModel.isLoading.bind { [weak self ]isLoading in
            guard let self = self else {return}
            guard let isLoading = isLoading else {return}
            if isLoading {
                activityIndicator.startAnimating()
            }else{
                activityIndicator.stopAnimating()
            }
        }
    }
    //MARK: - IBActions
    @IBAction func loginBtnAction(_ sender: Any) {
        bindViewModel()
        guard let loginUser = viewModel.loginwWithValidation(emailTxtField.text, passwordTxField.text) else {
            return
        }
        showALert(message: loginUser)
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        passwordTxField.isSecureTextEntry.toggle()
        if passwordTxField.isSecureTextEntry{
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }else{
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
}

extension LoginVC : LoginVCViewModelDelegate{
    func loginIsDone(_ message: String) {
        navigationController?.pushViewControllerWithModalTransition(viewController: HomeVC())
    }
    
    func loginIsFail(_ message: String) {
        showALert(message: message)
    }
}
