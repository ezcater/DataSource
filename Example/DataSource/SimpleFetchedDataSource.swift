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
        
        fetchedResultsController.delegate = self
    }
    
    deinit {
        fetchedResultsController.delegate = nil
    }
    
    func addItem() {
        Item.addItem()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension SimpleFetchedDataSource: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reloadBlock?([])
    }
}
