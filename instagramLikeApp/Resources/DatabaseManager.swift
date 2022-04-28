//
//  DatabaseManager.swift
//  instagramLikeApp
//
//  Created by Cumulations Technologies Private Limited on 27/04/22.
//


import FirebaseDatabase

public class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    public let database = Database.database().reference()
    /// Check if username and password is available
    /// - Parameters
    ///  - email: string representing email
    ///   -username: string representing username
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    /// insert new username and email to database
    /// - Parameters
    ///  - email: string representing email
    ///   -username: string representing username
    ///   -completion: async callback for result if database entry succeded
    
    public func insertNewUser(with email: String, username: String,  completion: @escaping (Bool) -> Void){
        
        let key = email.safeDatabaseKey()
        print(key)
        
        self.database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil{
                //success
                completion(true)
                print("saved")
                return
            }
            else{
                //error
                completion(false)
                return
            }
        }
    }
    
}
