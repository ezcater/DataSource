//
//  AnyListDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation

private class AnyListDataSourceBase<ModelType>: ListDataSource {
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
    
    func item(at indexPath: IndexPath) -> ModelType? {
        fatalError("Must override")
    }
    
    // ListDataSource
    
    var items: [ModelType] {
        fatalError("Must override")
    }
}

private final class AnyListDataSourceBox<Concrete: ListDataSource>: AnyListDataSourceBase<Concrete.ModelType> {
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
    
    // ListDataSource
    
    override var items: [ModelType] {
        return concrete.items
    }
}

public final class AnyListDataSource<ModelType>: ListDataSource {
    private let box: AnyListDataSourceBase<ModelType>
    
    public init<Concrete: ListDataSource>(dataSource: Concrete) where Concrete.ModelType == ModelType {
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
    
    public func item(at indexPath: IndexPath) -> ModelType? {
        return box.item(at: indexPath)
    }
    
    // ListDataSource
    
    public var items: [ModelType] {
        return box.items
    }
}
