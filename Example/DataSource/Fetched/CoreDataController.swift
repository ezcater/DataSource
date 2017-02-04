//
//  CoreDataController.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController {
    static let sharedInstance = CoreDataController(modelName: "FetchedDataSource")
    
    let mainContext: NSManagedObjectContext
    
    private init(modelName: String) {
        let bundle = Bundle(for: type(of: self))
        let managedObjectModel = NSManagedObjectModel(name: modelName, bundle: bundle)
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let filename = "\(modelName).sqlite"
        let storeUrl = directory?.appendingPathComponent(filename)
        let type = NSInMemoryStoreType
        
        guard let model = managedObjectModel, let url = storeUrl else {
            preconditionFailure()
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(model: model, type: type, url: url)
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
}

// MARK: - NSManagedObjectModel

extension NSManagedObjectModel {
    convenience init?(name: String, bundle: Bundle) {
        guard let url = bundle.url(forResource: name, withExtension: "momd") ?? bundle.url(forResource: name, withExtension: "mom") else {
            return nil
        }
        
        self.init(contentsOf: url)
    }
}

// MARK: - NSPersistentStoreCoordinator

extension NSPersistentStoreCoordinator {
    convenience init(model: NSManagedObjectModel, type: String, url: URL) {
        self.init(managedObjectModel: model)
        
        do {
            try addPersistentStore(ofType: type, configurationName: nil, at: url, options: nil)
        }
        catch(let error) {
            preconditionFailure("Failed to add persistent store with error: \(error)")
        }
    }
}
