//
//  SectionedDataSourceTests.swift
//  DataSource
//
//  Created by Brad Smith on 2/2/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import XCTest
import EZDataSource

class SectionedDataSourceTests: XCTestCase {
    var dataSource = TestSectionedDataSource()

    func testNumberOfSections() {
        XCTAssertEqual(3, dataSource.numberOfSections)
        XCTAssertEqual(dataSource.sections.count, dataSource.numberOfSections)
    }

    func testNumberOfItems() {
        var section = 0
        XCTAssertEqual(3, dataSource.numberOfItems(in: section))
        XCTAssertEqual(dataSource.sections[section].items.count, dataSource.numberOfItems(in: section))

        section = 1
        XCTAssertEqual(2, dataSource.numberOfItems(in: section))
        XCTAssertEqual(dataSource.sections[section].items.count, dataSource.numberOfItems(in: section))

        section = 2
        XCTAssertEqual(1, dataSource.numberOfItems(in: section))
        XCTAssertEqual(dataSource.sections[section].items.count, dataSource.numberOfItems(in: section))
    }

    func testItems() {
        var indexPath = IndexPath(item: 0, section: 0)
        XCTAssertEqual("0.0", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.sections[indexPath.section].items[indexPath.item], dataSource.item(at: indexPath))

        indexPath.item = 1
        XCTAssertEqual("0.1", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.sections[indexPath.section].items[indexPath.item], dataSource.item(at: indexPath))

        indexPath.item = 2
        XCTAssertEqual("0.2", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.sections[indexPath.section].items[indexPath.item], dataSource.item(at: indexPath))

        indexPath.item = 0
        indexPath.section = 1
        XCTAssertEqual("1.0", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.sections[indexPath.section].items[indexPath.item], dataSource.item(at: indexPath))

        indexPath.item = 1
        XCTAssertEqual("1.1", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.sections[indexPath.section].items[indexPath.item], dataSource.item(at: indexPath))

        indexPath.item = 0
        indexPath.section = 2
        XCTAssertEqual("2.0", dataSource.item(at: indexPath))
        XCTAssertEqual(dataSource.sections[indexPath.section].items[indexPath.item], dataSource.item(at: indexPath))

        indexPath.item = 1
        XCTAssertNil(dataSource.item(at: indexPath))
    }

    func testHeaderFooterTitles() {
        var section = 0
        XCTAssertEqual("header0", dataSource.headerTitle(for: section))
        XCTAssertEqual(dataSource.sections[section].headerTitle, dataSource.headerTitle(for: section))

        section = 1
        XCTAssertEqual("header1", dataSource.headerTitle(for: section))
        XCTAssertEqual(dataSource.sections[section].headerTitle, dataSource.headerTitle(for: section))

        section = 2
        XCTAssertNil(dataSource.headerTitle(for: section))
        XCTAssertNil(dataSource.sections[section].headerTitle)

        section = 0
        XCTAssertEqual("footer0", dataSource.footerTitle(for: section))
        XCTAssertEqual(dataSource.sections[section].footerTitle, dataSource.footerTitle(for: section))

        section = 1
        XCTAssertNil(dataSource.footerTitle(for: section))
        XCTAssertNil(dataSource.sections[section].footerTitle)

        section = 2
        XCTAssertEqual("footer2", dataSource.footerTitle(for: section))
        XCTAssertEqual(dataSource.sections[section].footerTitle, dataSource.footerTitle(for: section))
    }
}

class TestSectionedDataSource: SectionedDataSource {
    typealias ItemType = String

    var sections: [Section<String>]
    var reloadBlock: ReloadBlock?

    init() {
        sections = [
            Section(items: ["0.0", "0.1", "0.2"], headerTitle: "header0", footerTitle: "footer0"),
            Section(items: ["1.0", "1.1"], headerTitle: "header1"),
            Section(items: ["2.0"], footerTitle: "footer2")
        ]
    }
}
