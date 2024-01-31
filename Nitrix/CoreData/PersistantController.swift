//
//  PersistantController.swift
//  Nitrix
//
//  Created by Misha Vrana on 30.01.2024.
//

import Foundation
import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    var container: NSPersistentContainer = NSPersistentContainer(name: "Favorites")
    
    private init() { }
    
    func setup() {
        container.loadPersistentStores { description, error in
            if let error = error  as NSError? {
                fatalError("Error loading container: \(error), \(error.userInfo)")
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    func save() {
        let context = container.viewContext
        
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
}
