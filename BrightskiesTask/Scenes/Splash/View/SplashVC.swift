//
//  SplashVC.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 20/08/2023.
//

import UIKit

class SplashVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var appLogoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logoStartAnimation()
    }
    //MARK: - Functions
    func setupUI(){
        setupColors()
        setupLogoAnimation()
    }
    
    func setupLogoAnimation(){
        appLogoImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        appLogoImage.alpha = 0.0
    }
    
    func setupColors(){
        view.backgroundColor = AppColors.green.color
    }
    
    func logoStartAnimation(){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.appLogoImage.transform = CGAffineTransform.identity
            self.appLogoImage.alpha = 1.0
            self.navigateToLogin()
        }, completion: nil)
    }
    
    func navigateToLogin(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let vc = LoginVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            if (UserDefaults.standard.string(forKey: "userEmail") != nil){
                self.navigationController?.pushViewControllerWithModalTransition(viewController: HomeVC())
            }else{
                self.navigationController?.pushViewControllerWithModalTransition(viewController: LoginVC())
            }
        }
    }
}
