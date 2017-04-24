//
//  UITableView+Extensions.swift
//  Pods
//
//  Created by Brad Smith on 4/24/17.
//
//

import Foundation
import UIKit

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
