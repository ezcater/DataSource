//
//  FetchedDataSource.swift
//  Pods
//
//  Created by Brad Smith on 2/2/17.
//
//

import Foundation
import CoreData

/**
 `FetchedDataSource` is a protocol for representing a `NSFetchedResultsController` based data source. `ModelType` represents an
 `NSFetchRequestResult` conforming type contained within the data source.
 */

public protocol FetchedDataSource: DataSource {
    associatedtype ModelType: NSFetchRequestResult
    
    /**
     Backing `NSFetchedResultsController` for the data source
     */
    
    var fetchedResultsController: NSFetchedResultsController<ModelType> { get }
}

// MARK: - Public

public extension FetchedDataSource {
    var numberOfSections: Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        
        return sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 else {
            return 0
        }
        
        guard let sections = fetchedResultsController.sections, section < sections.count else {
            return 0
        }
        
        return sections[section].numberOfObjects
    }
    
    func item(at indexPath: IndexPath) -> ModelType? {
        guard indexPath.section >= 0, indexPath.item >= 0 else {
            return nil
        }
        
        guard let sections = fetchedResultsController.sections, indexPath.section < sections.count else {
            return nil
        }
        
        let section = sections[indexPath.section]
        
        guard indexPath.item < section.numberOfObjects else {
            return nil
        }
        
        return fetchedResultsController.object(at: indexPath)
    }
}
