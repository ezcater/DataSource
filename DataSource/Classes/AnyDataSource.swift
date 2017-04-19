//
//  AnyDataSource.swift
//  Pods
//
//  Created by Brad Smith on 4/19/17.
//
//

import Foundation

private class AnyDataSourceBase<ModelType>: DataSource {
    init() {
        guard type(of: self) != AnyDataSourceBase.self else {
            fatalError("AnyDataSourceBase is an abstract class")
        }
    }
    
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
}

private final class AnyDataSourceBox<Concrete: DataSource>: AnyDataSourceBase<Concrete.ModelType> {
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
    
    override func item(at indexPath: IndexPath) -> ModelType? {
        return concrete.item(at: indexPath)
    }
}

public final class AnyDataSource<ModelType>: DataSource {
    private let box: AnyDataSourceBase<ModelType>
    
    public init<Concrete: DataSource>(dataSource: Concrete) where Concrete.ModelType == ModelType {
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
    
    public func item(at indexPath: IndexPath) -> ModelType? {
        return box.item(at: indexPath)
    }
}
