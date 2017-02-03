//
//  DataSource.swift
//  Pods
//
//  Created by Brad Smith on 2/2/17.
//
//

import Foundation

/**
 Passes back a single array parameter containing `IndexPath`s that have been invalidated. 
 If the array is empty, it signifies that all `IndexPath`s are invalid.
 */

public typealias ReloadBlock = ([IndexPath]) -> Void

/**
 `DataSource` is a protocol for representing a backing data source. It is UI-independent and tailored for use with
 `UITableView` and `UICollectionView`. It utilizes `IndexPath` to access items and a `ReloadBlock` to communicate changes. 
 `ModelType` represents the type of items contained within the data source.
 */

public protocol DataSource {
    associatedtype ModelType
    
    /**
     Callback to signify that the backing data has changed.
     */
    
    var reloadBlock: ReloadBlock? { get set }
    
    /**
     Returns the number of sections in the backing data.
     */
    
    var numberOfSections: Int { get }
    
    /**
     Returns the number of items in a specificed section.
     
     - Parameter section: Section represented by an `Int`
     
     - Returns: The number of items in the specified `section`, or `0` if the data source does not contain the `section`
     */
    
    func numberOfItems(in section: Int) -> Int
    
    /**
     Returns the item at the specified `IndexPath`.
     
     - Parameter indexPath: Represents the desired section and item
     
     - Returns: The item at the specified `indexPath`, or `nil` if the data source does not contain `indexPath`
     */
    
    func item(at indexPath: IndexPath) -> ModelType?
}
