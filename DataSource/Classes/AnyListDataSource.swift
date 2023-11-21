//
//  AnyListDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation

private class AnyListDataSourceBase<ItemType>: ListDataSource {
    init() {
        guard type(of: self) != AnyListDataSourceBase.self else {
            fatalError("AnyListDataSourceBase is an abstract class")
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

    func item(at indexPath: IndexPath) -> ItemType? {
        fatalError("Must override")
    }

    func indexPath(after indexPath: IndexPath) -> IndexPath? {
        fatalError("Must override")
    }

    // ListDataSource

    var items: [ItemType] {
        fatalError("Must override")
    }
}

private final class AnyListDataSourceBox<Concrete: ListDataSource>: AnyListDataSourceBase<Concrete.ItemType> {
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

    // ListDataSource

    override var items: [ItemType] {
        return concrete.items
    }
}

public final class AnyListDataSource<ItemType>: ListDataSource {
    private let box: AnyListDataSourceBase<ItemType>

    public init<Concrete: ListDataSource>(dataSource: Concrete) where Concrete.ItemType == ItemType {
        box = AnyListDataSourceBox(concrete: dataSource)
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

    // ListDataSource

    public var items: [ItemType] {
        return box.items
    }
}
