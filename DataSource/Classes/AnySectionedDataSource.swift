//
//  AnySectionedDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation

private class AnySectionedDataSourceBase<ModelType, SectionType>: SectionedDataSource {
    init() {
        guard type(of: self) != AnySectionedDataSourceBase.self else {
            fatalError("AnySectionedDataSourceBase is an abstract class")
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
    
    // SectionedDataSource
    
    var sections: [SectionType] {
        fatalError("Must override")
    }
    
    func headerTitle(for section: Int) -> String? {
        fatalError("Must override")
    }
    
    func footerTitle(for section: Int) -> String? {
        fatalError("Must override")
    }
}

private final class AnySectionedDataSourceBox<Concrete: SectionedDataSource>: AnySectionedDataSourceBase<Concrete.ModelType, Concrete.SectionType> {
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
    
    // SectionedDataSource
    
    override var sections: [SectionType] {
        return concrete.sections
    }
    
    override func headerTitle(for section: Int) -> String? {
        return concrete.headerTitle(for: section)
    }
    
    override func footerTitle(for section: Int) -> String? {
        return concrete.footerTitle(for: section)
    }
}

public final class AnySectionedDataSource<ModelType, SectionType>: SectionedDataSource {
    private let box: AnySectionedDataSourceBase<ModelType, SectionType>
    
    public init<Concrete: SectionedDataSource>(dataSource: Concrete) where Concrete.ModelType == ModelType, Concrete.SectionType == SectionType {
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
    
    public func item(at indexPath: IndexPath) -> ModelType? {
        return box.item(at: indexPath)
    }
    
    // SectionedDataSource
    
    public var sections: [SectionType] {
        return box.sections
    }
    
    public func headerTitle(for section: Int) -> String? {
        return box.headerTitle(for: section)
    }
    
    public func footerTitle(for section: Int) -> String? {
        return box.footerTitle(for: section)
    }
}
