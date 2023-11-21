//
//  AnyFetchedDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import CoreData
import Foundation

private class AnyFetchedDataSourceBase<ItemType: NSFetchRequestResult>: FetchedDataSource {
    init() {
        guard type(of: self) != AnyFetchedDataSourceBase.self else {
            fatalError("AnyFetchedDataSourceBase is an abstract class")
        }
    }

    // DataSource

    var numberOfSections: Int {
        fatalError("Must override")
    }

    // swiftlint: disable unused_setter_value
    var reloadBlock: ReloadBlock? {
        get { fatalError("Must override") }
        set { fatalError("Must override") }
    }
    // swiftlint: enable unused_setter_value

    func numberOfItems(in section: Int) -> Int {
        fatalError("Must override")
    }

    func item(at indexPath: IndexPath) -> ItemType? {
        fatalError("Must override")
    }

    func indexPath(after indexPath: IndexPath) -> IndexPath? {
        fatalError("Must override")
    }

    // FetchedDataSource

    var fetchedResultsController: NSFetchedResultsController<ItemType> {
        fatalError("Must override")
    }

    func registerForFetchedChanges() {
        fatalError("Must override")
    }

    func unregisterForFetchedChanges() {
        fatalError("Must override")
    }
}

private final class AnyFetchedDataSourceBox<Concrete: FetchedDataSource>: AnyFetchedDataSourceBase<Concrete.ItemType> {
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

    override func item(at indexPath: IndexPath) -> ItemType? {
        return concrete.item(at: indexPath)
    }

    override func indexPath(after indexPath: IndexPath) -> IndexPath? {
        return concrete.indexPath(after: indexPath)
    }

    // FetchedDataSource

    override var fetchedResultsController: NSFetchedResultsController<ItemType> {
        return concrete.fetchedResultsController
    }

    override func registerForFetchedChanges() {
        concrete.registerForFetchedChanges()
    }

    override func unregisterForFetchedChanges() {
        concrete.unregisterForFetchedChanges()
    }
}

public final class AnyFetchedDataSource<ItemType: NSFetchRequestResult>: FetchedDataSource {
    private let box: AnyFetchedDataSourceBase<ItemType>

    public init<Concrete: FetchedDataSource>(dataSource: Concrete) where Concrete.ItemType == ItemType {
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

    public func item(at indexPath: IndexPath) -> ItemType? {
        return box.item(at: indexPath)
    }

    public func indexPath(after indexPath: IndexPath) -> IndexPath? {
        return box.indexPath(after: indexPath)
    }

    // FetchedDataSource

    public var fetchedResultsController: NSFetchedResultsController<ItemType> {
        return box.fetchedResultsController
    }

    public func registerForFetchedChanges() {
        box.registerForFetchedChanges()
    }

    public func unregisterForFetchedChanges() {
        box.unregisterForFetchedChanges()
    }
}
