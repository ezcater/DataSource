//
//  SimpleFetchedDataSource.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import CoreData
import EZDataSource
import Foundation

class SimpleFetchedDataSource: NSObject, FetchedDataSource {
    typealias ItemType = Item
    
    private(set) var fetchedResultsController: NSFetchedResultsController<Item>
    
    var reloadBlock: ReloadBlock?
    
    override init() {
        fetchedResultsController = Item.fetchedItems
        
        super.init()
        
        registerForFetchedChanges()
    }
    
    deinit {
        unregisterForFetchedChanges()
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
