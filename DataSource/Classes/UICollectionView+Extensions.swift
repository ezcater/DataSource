//
//  UICollectionView+Extensions.swift
//  Pods
//
//  Created by Brad Smith on 4/24/17.
//
//

import Foundation
import UIKit

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
