//
//  CoreDataUtils.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 28/02/23.
//

import Foundation
import CoreData
/* This provides an easy wrapper for CoreData */
struct CoreDataUtils {
    
    /* Hold the CoreData PersistentContainer */
    static let coreDataContainer: NSPersistentContainer = NSPersistentContainer(name: "Main")
    
    static func viewContext() -> NSManagedObjectContext {
        return coreDataContainer.viewContext
    }
    

    
    static func initialize() {
        coreDataContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal Error loading store: \(error.localizedDescription)")
            }
        }
        
    }
}
