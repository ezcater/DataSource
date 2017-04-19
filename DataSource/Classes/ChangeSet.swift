//
//  ChangeSet.swift
//  Pods
//
//  Created by Brad Smith on 3/29/17.
//
//

import UIKit
import CoreData

public typealias ChangeSetCompletion = (Bool) -> Void

public enum ChangeSet {
    case some([Change])
    case all
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
    func performUpdates(withChangeSet changeSet: ChangeSet, completion: ChangeSetCompletion? = nil) {
        switch changeSet {
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
    func performUpdates(withChangeSet changeSet: ChangeSet, completion: ChangeSetCompletion? = nil) {
        switch changeSet {
        case .some(let changes):
            let updates = {
                changes.forEach { change in
                    switch change {
                    case .section(let type):
                        switch type {
                        case .insert(let indexPath):
                            let indexSet = IndexSet(integer: indexPath.section)
                            self.insertSections(indexSet)
                        case .delete(let indexPath):
                            let indexSet = IndexSet(integer: indexPath.section)
                            self.deleteSections(indexSet)
                        case .move(let oldIndexPath, let newIndexPath):
                            self.moveSection(oldIndexPath.section, toSection: newIndexPath.section)
                        case .update(let indexPath):
                            let indexSet = IndexSet(integer: indexPath.section)
                            self.reloadSections(indexSet)
                        }
                        
                    case .object(let type):
                        switch type {
                        case .insert(let indexPath):
                            self.insertItems(at: [indexPath])
                        case .delete(let indexPath):
                            self.deleteItems(at: [indexPath])
                        case .move(let oldIndexPath, let newIndexPath):
                            self.moveItem(at: oldIndexPath, to: newIndexPath)
                        case .update(let indexPath):
                            self.reloadItems(at: [indexPath])
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
