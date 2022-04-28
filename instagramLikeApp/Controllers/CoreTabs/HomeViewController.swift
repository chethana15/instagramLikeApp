//
//  ViewController.swift
//  instagramLikeApp
//
//  Created by Cumulations Technologies Private Limited on 26/04/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try Auth.auth().signOut()
        }
        catch{
            print("failed to sign out")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      handleNotAuthenticated()
    }

    func handleNotAuthenticated(){
       
        //check auth status
        if Auth.auth().currentUser == nil{
            //show or direct to login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

