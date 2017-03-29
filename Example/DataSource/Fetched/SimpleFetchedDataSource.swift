//
//  SimpleFetchedDataSource.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import Foundation
import CoreData
import DataSource

class SimpleFetchedDataSource: NSObject, FetchedDataSource {
    typealias ModelType = Item
    
    fileprivate(set) var fetchedResultsController: NSFetchedResultsController<Item>
    
    var reloadBlock: ReloadBlock?
    
    override init() {
        fetchedResultsController = Item.fetchedItems
        
        super.init()
        
        register(fetchedResultsController: fetchedResultsController)
    }
    
    deinit {
        unregister(fetchedResultsController: fetchedResultsController)
    }
    
    func addItem() {
        let count = numberOfItems(in: 0)
        Item.addItem(withTitle: "Item \(count)")
    }
    
    func deleteItem(at indexPath: IndexPath) {
        guard let item = item(at: indexPath) else {
            return
        }
        
        Item.delete(item: item)
    }
}
