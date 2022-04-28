//
//  AuthManager.swift
//  instagramLikeApp
//
//  Created by Cumulations Technologies Private Limited on 27/04/22.
//


import FirebaseAuth

public class AuthManager{
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping(Bool) -> Void){
        /*
         - check if username is available
         - check if email is available
         - create account
         - insert account to database
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            
            if canCreate{
                /*
                 create account
                 insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard result != nil, error == nil
                    else{
                        //firebaseauth couldn't create account
                        completion(false)
                        return
                    }
                    //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else{
                            //failed to create new user in database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else{
                //either email or username doesn't exists
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        
        if let email = email{
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }
        else if let username = username {
            //username log in
            print(username)
        }
        
    }
}
