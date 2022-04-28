//
//  RegistrationViewController.swift
//  instagramLikeApp
//
//  Created by Cumulations Technologies Private Limited on 26/04/22.
//

import UIKit

class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Username"
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
    
    private let emailField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "email address"
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        usernameField.delegate = self
        emailField.delegate = self
        userPasswordField.delegate = self
        
        view.addSubview(usernameField)
        view.addSubview(userPasswordField)
        view.addSubview(emailField)
        view.addSubview(registerButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            //it's necessary to place them in order else textfields will not be placed as per program sometimes
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top , width: view.width - 40, height: 40)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: usernameField.width, height: usernameField.height)
        userPasswordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: usernameField.width, height: usernameField.height)
        registerButton.frame = CGRect(x: 20, y: userPasswordField.bottom + 10, width: usernameField.width, height: usernameField.height)
        
    }
    @objc private func didTapRegisterButton(){
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        userPasswordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = userPasswordField.text, !password.isEmpty, password.count >= 8,
              let username = usernameField.text, !username.isEmpty else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered{
                    //good to go
                }
                else{
                    //failed
                }
            }
        }
    }
 

}
extension RegistrationViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            userPasswordField.becomeFirstResponder()
        }
        else{
            didTapRegisterButton()
        }
     return true
    }
}
