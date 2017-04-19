//
//  AnyFetchedDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation
import CoreData

private class AnyFetchedDataSourceBase<ModelType: NSFetchRequestResult>: FetchedDataSource {
    init() {
        guard type(of: self) != AnyFetchedDataSourceBase.self else {
            fatalError("AnyFetchedDataSourceBase is an abstract class")
        }
    }
    
    // DataSource
    
    var numberOfSections: Int {
        fatalError("Must override")
    }
    
    var reloadBlock: ReloadBlock? {
        get { fatalError("Must override") }
        set { fatalError("Must override") }
    }
    
    func numberOfItems(in section: Int) -> Int {
        fatalError("Must override")
    }
    
    func item(at indexPath: IndexPath) -> ModelType? {
        fatalError("Must override")
    }
    
    // FetchedDataSource
    
    var fetchedResultsController: NSFetchedResultsController<ModelType> {
        fatalError("Must override")
    }
    
    func registerForFetchedChanges() {
        fatalError("Must override")
    }
    
    func unregisterForFetchedChanges() {
        fatalError("Must override")
    }
}

private final class AnyFetchedDataSourceBox<Concrete: FetchedDataSource>: AnyFetchedDataSourceBase<Concrete.ModelType> {
    var concrete: Concrete
    
    init(concrete: Concrete) {
        self.concrete = concrete
    }
    
    // DataSource
    
    override var numberOfSections: Int {
        return concrete.numberOfSections
    }
    
    override var reloadBlock: ReloadBlock? {
        get {
            return concrete.reloadBlock
        }
        set {
            concrete.reloadBlock = newValue
        }
    }
    
    override func numberOfItems(in section: Int) -> Int {
        return concrete.numberOfItems(in: section)
    }
    
    override func item(at indexPath: IndexPath) -> ModelType? {
        return concrete.item(at: indexPath)
    }
    
    // FetchedDataSource
    
    override var fetchedResultsController: NSFetchedResultsController<ModelType> {
        return concrete.fetchedResultsController
    }
    
    override func registerForFetchedChanges() {
        concrete.registerForFetchedChanges()
    }
    
    override func unregisterForFetchedChanges() {
        concrete.unregisterForFetchedChanges()
    }
}

public final class AnyFetchedDataSource<ModelType: NSFetchRequestResult>: FetchedDataSource {
    private let box: AnyFetchedDataSourceBase<ModelType>
    
    public init<Concrete: FetchedDataSource>(dataSource: Concrete) where Concrete.ModelType == ModelType {
        box = AnyFetchedDataSourceBox(concrete: dataSource)
    }
    
    // DataSource
    
    public var numberOfSections: Int {
        return box.numberOfSections
    }
    
    public var reloadBlock: ReloadBlock? {
        get {
            return box.reloadBlock
        }
        set {
            box.reloadBlock = newValue
        }
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return box.numberOfItems(in: section)
    }
    
    public func item(at indexPath: IndexPath) -> ModelType? {
        return box.item(at: indexPath)
    }
    
    // FetchedDataSource
    
    public var fetchedResultsController: NSFetchedResultsController<ModelType> {
        return box.fetchedResultsController
    }
    
    public func registerForFetchedChanges() {
        box.registerForFetchedChanges()
    }
    
    public func unregisterForFetchedChanges() {
        box.unregisterForFetchedChanges()
    }
}
