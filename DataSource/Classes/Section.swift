//
//  Section.swift
//  Pods
//
//  Created by Brad Smith on 2/2/17.
//
//

import Foundation

/**
 A generic object that represents a section. Designed to be used in unison with `SectionedDataSource` and `UITableView`/`UICollectionView`, but
 may be used independently. Generic type `ModelType` represents the containing items. Subclassable.
 */

open class Section<ModelType> {
    
    /**
     An array of items of type `ModelType`.
     */
    
    public var items: [ModelType]
    
    /**
     A `String` designed to be used with `UITableView` or `UICollectionView` section header views.
     */
    
    public var headerTitle: String?
    
    /**
     A `String` designed to be used with `UITableView` or `UICollectionView` section footer views.
     */
    
    public var footerTitle: String?
    
    /**
     Initializes and return a `Section` object with the given items and optionally a header title or footer title.
     
     - Parameter items: Array of items of generic type `ModelType`
     - Parameter headerTitle: Optional `String` to be used as a header
     - Parameter footerTitle: Optional `String` to be used as a footer
     */
    
    public init(items: [ModelType], headerTitle: String? = nil, footerTitle: String? = nil) {
        self.items = items
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}
