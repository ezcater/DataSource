//
//  AnyDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation

private class AnyDataSourceBase<ItemType>: DataSource {
    init() {
        guard type(of: self) != AnyDataSourceBase.self else {
            fatalError("AnyDataSourceBase is an abstract class")
        }
    }

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
}

private final class AnyDataSourceBox<Concrete: DataSource>: AnyDataSourceBase<Concrete.ItemType> {
    var concrete: Concrete

    init(concrete: Concrete) {
        self.concrete = concrete
    }

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
}

public final class AnyDataSource<ItemType>: DataSource {
    private let box: AnyDataSourceBase<ItemType>

    public init<Concrete: DataSource>(dataSource: Concrete) where Concrete.ItemType == ItemType {
        box = AnyDataSourceBox(concrete: dataSource)
    }

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
}
