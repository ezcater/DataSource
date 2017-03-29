//
//  ChangeSet.swift
//  Pods
//
//  Created by Brad Smith on 3/29/17.
//
//

import UIKit
import CoreData

public enum ChangeSet {
    case none
    case some([Change])
    case all
    
    public init(changes: [Change]) {
        self = changes.isEmpty ? .none : .some(changes)
    }
}

// MARK: - Change

public enum Change {
    case section(type: ChangeType)
    case object(type: ChangeType)
}

// MARK: - ChangeType

public enum ChangeType {
    case insert(IndexPath)
    case delete(IndexPath)
    case move(IndexPath, IndexPath)
    case update(IndexPath)
    
    public init?(type: NSFetchedResultsChangeType, indexPath: IndexPath?, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {
                return nil
            }
            
            self = .insert(newIndexPath)
        case .delete:
            guard let indexPath = indexPath else {
                return nil
            }
            
            self = .delete(indexPath)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {
                return nil
            }
            
            self = .move(indexPath, newIndexPath)
        case .update:
            guard let indexPath = indexPath else {
                return nil
            }
            
            self = .update(indexPath)
        }
    }
}

// MARK: - UITableView

public extension UITableView {
    func perform(changeSet: ChangeSet, completion: ((Bool) -> Void)? = nil) {
        switch changeSet {
        case .none:
            completion?(true)
        case .some(let changes):
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                completion?(true)
            }
            
            beginUpdates()
            
            changes.forEach { change in
                switch change {
                case .section(let type):
                    switch type {
                    case .insert(let indexPath):
                        let indexSet = IndexSet(integer: indexPath.section)
                        insertSections(indexSet, with: .none)
                    case .delete(let indexPath):
                        let indexSet = IndexSet(integer: indexPath.section)
                        deleteSections(indexSet, with: .none)
                    case .move(let oldIndexPath, let newIndexPath):
                        moveSection(oldIndexPath.section, toSection: newIndexPath.section)
                    case .update(let indexPath):
                        let indexSet = IndexSet(integer: indexPath.section)
                        reloadSections(indexSet, with: .none)
                    }
                    
                case .object(let type):
                    switch type {
                    case .insert(let indexPath):
                        insertRows(at: [indexPath], with: .none)
                    case .delete(let indexPath):
                        deleteRows(at: [indexPath], with: .none)
                    case .move(let oldIndexPath, let newIndexPath):
                        moveRow(at: oldIndexPath, to: newIndexPath)
                    case .update(let indexPath):
                        reloadRows(at: [indexPath], with: .none)
                    }
                }
            }
            
            endUpdates()
            
            CATransaction.commit()
        case .all:
            reloadData()
            completion?(true)
        }
    }
}

// MARK: - UICollectionView

public extension UICollectionView {
    func perform(changeSet: ChangeSet, completion: ((Bool) -> Void)? = nil) {
        switch changeSet {
        case .none:
            completion?(true)
        case .some(let changes):
            let updates = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                changes.forEach { change in
                    switch change {
                    case .section(let type):
                        switch type {
                        case .insert(let indexPath):
                            let indexSet = IndexSet(integer: indexPath.section)
                            strongSelf.insertSections(indexSet)
                        case .delete(let indexPath):
                            let indexSet = IndexSet(integer: indexPath.section)
                            strongSelf.deleteSections(indexSet)
                        case .move(let oldIndexPath, let newIndexPath):
                            strongSelf.moveSection(oldIndexPath.section, toSection: newIndexPath.section)
                        case .update(let indexPath):
                            let indexSet = IndexSet(integer: indexPath.section)
                            strongSelf.reloadSections(indexSet)
                        }
                        
                    case .object(let type):
                        switch type {
                        case .insert(let indexPath):
                            strongSelf.insertItems(at: [indexPath])
                        case .delete(let indexPath):
                            strongSelf.deleteItems(at: [indexPath])
                        case .move(let oldIndexPath, let newIndexPath):
                            strongSelf.moveItem(at: oldIndexPath, to: newIndexPath)
                        case .update(let indexPath):
                            strongSelf.reloadItems(at: [indexPath])
                        }
                    }
                }
            }
            
            performBatchUpdates(updates, completion: completion)
        case .all:
            reloadData()
            completion?(true)
        }
    }
}
