//
//  FetchedDataSourceTests.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import XCTest
import DataSource
import CoreData

class FetchedDataSourceTests: XCTestCase {
    var dataSource = TestFetchedDataSource()
    
    override class func setUp() {
        super.setUp()
        
        Item.addItem(withTitle: "0")
        Item.addItem(withTitle: "1")
        Item.addItem(withTitle: "2")
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(1, dataSource.numberOfSections)
    }
    
    func testNumberOfItems() {
        XCTAssertEqual(3, dataSource.numberOfItems(in: 0))
        
        XCTAssertEqual(0, dataSource.numberOfItems(in: 1))
        
        guard let count = dataSource.fetchedResultsController.sections?.first?.numberOfObjects else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(count, dataSource.numberOfItems(in: 0))
    }
    
    func testItems() {
        var indexPath = IndexPath(item: 0, section: 0)
        XCTAssertEqual("0", dataSource.item(at: indexPath)?.title)
        XCTAssertEqual(dataSource.fetchedResultsController.object(at: indexPath).title, dataSource.item(at: indexPath)?.title)
        
        indexPath.item = 1
        XCTAssertEqual("1", dataSource.item(at: indexPath)?.title)
        XCTAssertEqual(dataSource.fetchedResultsController.object(at: indexPath).title, dataSource.item(at: indexPath)?.title)
        
        indexPath.item = 2
        XCTAssertEqual("2", dataSource.item(at: indexPath)?.title)
        XCTAssertEqual(dataSource.fetchedResultsController.object(at: indexPath).title, dataSource.item(at: indexPath)?.title)
        
        indexPath.item = 3
        XCTAssertNil(dataSource.item(at: indexPath))
        
        indexPath.item = 0
        indexPath.section = 1
        XCTAssertNil(dataSource.item(at: indexPath))
        
        indexPath.item = -1
        indexPath.section = 0
        XCTAssertNil(dataSource.item(at: indexPath))
        
        indexPath.item = 0
        indexPath.section = -1
        XCTAssertNil(dataSource.item(at: indexPath))
    }
}

class TestFetchedDataSource: NSObject, FetchedDataSource {
    typealias ModelType = Item
    
    fileprivate(set) var fetchedResultsController: NSFetchedResultsController<Item>
    
    var reloadBlock: ReloadBlock?
    
    override init() {
        fetchedResultsController = Item.fetchedItems
        
        super.init()
        
        registerForFetchedChanges()
    }
    
    deinit {
        unregisterForFetchedChanges()
    }
}
