//
//  User.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 28/02/23.
//

import Foundation
import CoreData

struct User {
    enum ErrorTypes: Error {
        case UserNotFound
        case PasswordIsIncorrect
        case UserAlreadyExists
    }
    
    struct Model {
        var name: String
        var password: String
    }

    static func findByName(name: String) throws -> Model {

        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")

        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let results = try CoreDataUtils.viewContext().fetch(fetchRequest)
            
        guard let user = results.first else {
            throw ErrorTypes.UserNotFound
        }
            
        return Model(
            name: user.name!,
            password: user.password!
        )
    }
    
    static func userExists(name: String) throws -> Bool {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")

        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let results = try CoreDataUtils.viewContext().fetch(fetchRequest)
            
        if results.first == nil {
            return true
        }
       
        return false
    }
    
    static func login(name: String, password: String) throws -> Model {
        let model = try findByName(name: name)
        
        if model.password != password {
            throw ErrorTypes.PasswordIsIncorrect
        }
        
        return Model(name: model.name, password: model.password)
    }
    
    static func register(name: String, password: String) throws -> Model {
        
        if try userExists(name: name) {
            throw ErrorTypes.UserAlreadyExists
        }
    
        let newUser = UserEntity(context: CoreDataUtils.viewContext())
        
        newUser.name = name
        newUser.password = password
    
        try CoreDataUtils.viewContext().save()
        return Model(name: name, password: password)
    }
    
}
