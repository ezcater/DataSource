//
//  SectionedDataSource.swift
//  Pods
//
//  Created by Brad Smith on 2/2/17.
//
//

import Foundation

/**
 `SectionedDataSource` is a protocol for representing a multi-section data source. `SectionType` represents the type 
 of sections contained within the data source.
 */

public protocol SectionedDataSource: DataSource {
    associatedtype SectionType: Section<ModelType>
    
    /**
     Backing array of `SectionType` elements which represent all of the sections.
     */
    
    var sections: [SectionType] { get }
    
    /**
     Returns the header title for a specificed section.
     
     - Parameter section: Section represented by an `Int`
     
     - Returns: The header title for a specificed section, or `nil` if one does not exist
     */
    
    func headerTitle(for section: Int) -> String?
    
    /**
     Returns the footer title for a specificed section.
     
     - Parameter section: Section represented by an `Int`
     
     - Returns: The footer title for a specificed section, or `nil` if one does not exist
     */
    
    func footerTitle(for section: Int) -> String?
}

// MARK: - Public

public extension SectionedDataSource where SectionType: Section<ModelType> {
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 else {
            return 0
        }
        
        guard section < sections.count else {
            return 0
        }
        
        return sections[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> ModelType? {
        guard indexPath.section >= 0, indexPath.item >= 0 else {
            return nil
        }
        
        guard indexPath.section < sections.count else {
            return nil
        }
        
        let section = sections[indexPath.section]
        
        guard indexPath.item < section.items.count else {
            return nil
        }
        
        return section.items[indexPath.item]
    }
    
    func headerTitle(for section: Int) -> String? {
        guard section >= 0 else {
            return nil
        }
        
        guard section < sections.count else {
            return nil
        }
        
        return sections[section].headerTitle
    }
    
    func footerTitle(for section: Int) -> String? {
        guard section >= 0 else {
            return nil
        }
        
        guard section < sections.count else {
            return nil
        }
        
        return sections[section].footerTitle
    }
    
    /**
     Function to retrieve the next present index path, determined by
     section and item.
     
     - Parameter indexPath: Preceeding index path
     
     - Returns: The index path after the specified `indexPath`, or `nil` if `indexPath`
     is the last one
     */
    
    func indexPath(after indexPath: IndexPath) -> IndexPath? {
        guard indexPath.section < sections.count else {
            return nil
        }
        
        let section = sections[indexPath.section]
        
        let nextItem = indexPath.item + 1
        if nextItem < section.items.count {
            return IndexPath(item: nextItem, section: indexPath.section)
        }
        
        let nextSection = indexPath.section + 1
        if nextSection < sections.count && !sections[nextSection].items.isEmpty {
            return IndexPath(item: 0, section: nextSection)
        }
        
        return nil
    }
}
