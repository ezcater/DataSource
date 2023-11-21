//
//  ChangeSet.swift
//  Pods
//
//  Created by Brad Smith on 3/29/17.
//
//

import CoreData
import UIKit

public typealias ChangeSetCompletion = (Bool) -> Void

public enum ChangeSet {
    case some([Change])
    case all
}

// MARK: - Change

public enum Change {
    case section(type: ChangeType)
    case item(type: ChangeType)
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

        @unknown default:
            return nil
        }
    }
}
