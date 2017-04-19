//
//  ListDataSource.swift
//  Pods
//
//  Created by Brad Smith on 2/2/17.
//
//

import Foundation

/**
 `ListDataSource` is a protocol for representing an array based data source. By default, it defines
 a single section.
 */

public protocol ListDataSource: DataSource {
    
    /**
     Backing array of `ItemType` elements which represents a single section.
     */
    
    var items: [ItemType] { get }
}

// MARK: - Public

public extension ListDataSource {
    var numberOfSections: Int {
        return items.isEmpty ? 0 : 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 else {
            return 0
        }
        
        guard section == 0 else {
            return 0
        }
        
        return items.count
    }
    
    func item(at indexPath: IndexPath) -> ItemType? {
        guard indexPath.section >= 0, indexPath.item >= 0 else {
            return nil
        }
        
        guard indexPath.section == 0 && indexPath.item < items.count else {
            return nil
        }
        
        return items[indexPath.item]
    }
}
