//
//  LoginViewController.swift
//  instagramLikeApp
//
//  Created by Cumulations Technologies Private Limited on 26/04/22.
//

import UIKit
import SafariServices
import FirebaseAuth
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameTextfield: UITextField = {
        //create, congigure and return view
        //anonymous closure helps to delcare static code so that program remains less clutter
        //in anonymous closure we cannot use 'self' as anonymous closure doesn't know wht self is abt
        //anonymous closure helps keeps all the code related to usernameTextfield at one place rather than here and there in program
       
        
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        
        return field
    }()
    
    private let userPasswordField: UITextField  = {
        
        
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        return field
    
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New user? Create an account", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and conditions", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy policy", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        //header.backgroundColor = .cyan
        let backgroundImageview = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageview)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTermsButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        
        usernameTextfield.delegate = self
        userPasswordField.delegate = self
        
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height / 3.0)
        configureHeaderview()
        
        usernameTextfield.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width - 50, height: 40)
        userPasswordField.frame = CGRect(x: 25, y: usernameTextfield.bottom + 10, width: usernameTextfield.width, height: usernameTextfield.height)
        loginButton.frame = CGRect(x: 25, y: userPasswordField.bottom + 10, width: usernameTextfield.width, height: usernameTextfield.height)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: usernameTextfield.width, height: usernameTextfield.height)

        privacyButton.frame = CGRect(x: 25, y: view.height - view.safeAreaInsets.bottom - 50, width: usernameTextfield.width, height: usernameTextfield.height)
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: usernameTextfield.width + 30, height: usernameTextfield.height)

        
    }
    
    private func configureHeaderview(){
        guard headerView.subviews.count == 1 else{
            return
        }
        guard let backgroundView = headerView.subviews.first else{
            return
        }
        backgroundView.frame = headerView.bounds
        
        //add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.0, y: view.safeAreaInsets.top, width: headerView.width / 2.0, height: headerView.height - view.safeAreaInsets.top)
    }

  private func addSubviews(){
      view.addSubview(usernameTextfield)
      view.addSubview(userPasswordField)
      view.addSubview(loginButton)
      view.addSubview(privacyButton)
      view.addSubview(termsButton)
      view.addSubview(headerView)
      view.addSubview(createAccountButton)
    }

    @objc private func didTapLoginButton(){
        userPasswordField.resignFirstResponder()
        usernameTextfield.resignFirstResponder()
        
        guard let usernameEmail = usernameTextfield.text , !usernameEmail.isEmpty,
        let password = userPasswordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        //login functionality
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            //email
            email = usernameEmail
        }
        else{
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success{
                    //user logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    //error occured
                    let alert = UIAlertController(title: "Log in error", message: "unable to log in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
           
        }
        
    }
    
    @objc private func didTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/477434105621119/?helpref=hc_fnav") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: 44))
//        view.addSubview(navBar)
//        let navItem = UINavigationItem(title: "Create Account")
//        navBar.setItems([navItem], animated: false)

        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }

}

extension LoginViewController: UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextfield{
            usernameTextfield.becomeFirstResponder()
        }
        else if textField == userPasswordField{
            didTapLoginButton()
        }
        
        return true
    }
}
