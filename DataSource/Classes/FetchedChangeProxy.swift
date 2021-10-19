//
//  FetchedChangeProxy.swift
//  Pods
//
//  Created by Brad Smith on 3/29/17.
//
//

import CoreData
import Foundation

class FetchedChangeProxy: NSObject {
    static var associatedKey = "com.ezcater.dataSource.fetchedChangeProxyAssociatedKey"
    
    private let reloadBlock: ReloadBlock?
    
    private var changes = [Change]()
    
    init(reloadBlock: ReloadBlock?) {
        self.reloadBlock = reloadBlock
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FetchedChangeProxy: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        changes.removeAll()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexPath = IndexPath(item: 0, section: sectionIndex)
        
        guard let changeType = ChangeType(type: type, indexPath: indexPath, newIndexPath: indexPath) else {
            return
        }
        
        let change = Change.section(type: changeType)
        changes.append(change)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let changeType = ChangeType(type: type, indexPath: indexPath, newIndexPath: newIndexPath) else {
            return
        }
        
        let change = Change.item(type: changeType)
        changes.append(change)
    }
    
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard !changes.isEmpty else {
            return
        }
        
        reloadBlock?(.some(changes))
    }
}
