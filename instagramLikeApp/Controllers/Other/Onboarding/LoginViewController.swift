//
//  LoginViewController.swift
//  instagramLikeApp
//
//  Created by Cumulations Technologies Private Limited on 26/04/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let usernameTextfield: UITextField = {
        return UITextField()
    }()
    
    private let userPassword: UITextField  = {
        
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    
    }()
    
    private let loginButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        return UIButton()
    }()
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    private let headerView: UIView = {
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
  private func addSubviews(){
      view.addSubview(usernameTextfield)
      view.addSubview(userPassword)
      view.addSubview(loginButton)
      view.addSubview(privacyButton)
      view.addSubview(termsButton)
      view.addSubview(headerView)
      view.addSubview(createAccountButton)
    }

    @objc private func didTapLoginButton(){}
    @objc private func didTermsButton(){}
    @objc private func didPrivacyButton(){}
    @objc private func didTapCreateAccountButton(){}

}
