//
//  Item+Extensions.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    static var entityName: String {
        return String(describing: self)
    }
    
    static var fetchedItems: NSFetchedResultsController<Item> {
        let fetchRequest = NSFetchRequest<Item>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Item.title), ascending: true)]
        let context = CoreDataController.sharedInstance.mainContext
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        try? fetchedResultsController.performFetch()
        
        return fetchedResultsController
    }
    
    static func addItem(withTitle title: String) {
        let context = CoreDataController.sharedInstance.mainContext
        context.performAndWait {
            let item = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? Item
            item?.title = title
            
            do {
                try context.save()
            }
            catch(let error) {
                print("Failed to save with error: \(error)")
            }
        }
        
    }
}
