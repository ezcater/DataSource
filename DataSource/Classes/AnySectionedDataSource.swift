//
//  AnySectionedDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation

private class AnySectionedDataSourceBase<GenericItemType, GenericSectionType: Section<GenericItemType>>: SectionedDataSource {
    typealias ItemType = GenericItemType
    typealias SectionType = GenericSectionType

    init() {
        guard type(of: self) != AnySectionedDataSourceBase.self else {
            fatalError("AnySectionedDataSourceBase is an abstract class")
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

    // SectionedDataSource

    var sections: [SectionType] {
        fatalError("Must override")
    }

    func section(at index: Int) -> SectionType? {
        fatalError("Must override")
    }

    func headerTitle(for section: Int) -> String? {
        fatalError("Must override")
    }

    func footerTitle(for section: Int) -> String? {
        fatalError("Must override")
    }
}

private final class AnySectionedDataSourceBox<Concrete: SectionedDataSource>: AnySectionedDataSourceBase<Concrete.ItemType, Concrete.SectionType> where Concrete.SectionType: Section<Concrete.ItemType> {
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

    // SectionedDataSource

    override var sections: [SectionType] {
        return concrete.sections
    }

    override func section(at index: Int) -> Concrete.SectionType? {
        return concrete.section(at: index)
    }

    override func headerTitle(for section: Int) -> String? {
        return concrete.headerTitle(for: section)
    }

    override func footerTitle(for section: Int) -> String? {
        return concrete.footerTitle(for: section)
    }
}

public final class AnySectionedDataSource<ItemType, SectionType: Section<ItemType>>: SectionedDataSource {
    private let box: AnySectionedDataSourceBase<ItemType, SectionType>

    public init<Concrete: SectionedDataSource>(dataSource: Concrete) where Concrete.ItemType == ItemType, Concrete.SectionType == SectionType {
        box = AnySectionedDataSourceBox(concrete: dataSource)
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

    // SectionedDataSource

    public var sections: [SectionType] {
        return box.sections
    }

    public func section(at index: Int) -> SectionType? {
        return box.section(at: index)
    }

    public func headerTitle(for section: Int) -> String? {
        return box.headerTitle(for: section)
    }

    public func footerTitle(for section: Int) -> String? {
        return box.footerTitle(for: section)
    }
}

