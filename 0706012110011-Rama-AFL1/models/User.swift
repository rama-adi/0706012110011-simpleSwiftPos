//
//  User.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 28/02/23.
//

import Foundation
import CoreData

struct User {
    static var users: [String: Model] = [:]
    
    static fileprivate let modelFilename = "_users._d"
    
    static fileprivate let storage = CodableStorage(storage: DiskStorage(
            path: AppStorageUtils.location()
        )
    )
    
    enum ErrorTypes: Error, LocalizedError {
        case UserNotFound(String)
        case PasswordIsIncorrect
        case UserAlreadyExists(String)
        
        var errorDescription: String? {
            switch self {
            case .UserNotFound(let user):
                return "User \(user) not found!"
            case .PasswordIsIncorrect:
                return "The password you provided is incorrect!"
            case .UserAlreadyExists(let username):
                return "The username \(username) is already taken!"
            }
        }
        
    }
    
    struct Model: Codable {
        var name: String
        var password: String
    }
    
    
    static fileprivate func loadUser() throws {
        do {
            users = try storage.fetch(for: modelFilename)
        } catch {
            try storage.save(users, for: modelFilename)
        }
    }
    
    static fileprivate func saveUser() throws {
        try storage.save(users, for: modelFilename)
    }

    static func findByName(name: String) throws -> Model {
        
        try loadUser()
        
        guard let user = users[name] else {
            throw ErrorTypes.UserNotFound(name)
        }
        
        return Model(
            name: user.name,
            password: user.password
        )
    }
    
    static func userExists(name: String) throws -> Bool {
        
        try loadUser()
        
        if users[name] == nil {
            return false
        }
        
        
        return true
    }
    
    static func login(name: String, password: String) throws -> Model {
        let model = try findByName(name: name)
        
        if model.password != password {
            throw ErrorTypes.PasswordIsIncorrect
        }
        
        return Model(name: model.name, password: model.password)
    }
    
    static func register(username: String, name: String, password: String) throws -> Model {
        
        if try userExists(name: name) {
            throw ErrorTypes.UserAlreadyExists(name)
        }

        let newUser = Model(
            name: name,
            password: password
        )
        
        users[username] = newUser
    
        try saveUser()
        
        return newUser
    }
    
}
