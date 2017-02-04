//
//  ListDataSourceTests.swift
//  DataSource
//
//  Created by Brad Smith on 2/2/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import XCTest
import DataSource

class ListDataSourceTests: XCTestCase {
    var dataSource = TestListDataSource()
    
    func testNumberOfSections() {
        XCTAssertEqual(1, dataSource.numberOfSections)
    }
    
    func testNumberOfItems() {
        XCTAssertEqual(3, dataSource.numberOfItems(in: 0))
        
        XCTAssertEqual(0, dataSource.numberOfItems(in: 1))
        
        XCTAssertEqual(dataSource.items.count, dataSource.numberOfItems(in: 0))
    }
    
    func testItems() {
        var indexPath = IndexPath(item: 0, section: 0)
        XCTAssertEqual("0", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.items[indexPath.item], dataSource.item(at: indexPath))
        
        indexPath.item = 1
        XCTAssertEqual("1", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.items[indexPath.item], dataSource.item(at: indexPath))
        
        indexPath.item = 2
        XCTAssertEqual("2", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.items[indexPath.item], dataSource.item(at: indexPath))
        
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

class TestListDataSource: ListDataSource {
    typealias ModelType = String
    
    var items: [String]
    var reloadBlock: ReloadBlock?
    
    init() {
        items = [
            "0",
            "1",
            "2"
        ]
    }
}
