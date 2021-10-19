//
//  SimpleSectionedDataSource.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import EZDataSource
import Foundation

class SimpleSectionedDataSource: SectionedDataSource {
    typealias ItemType = String
    typealias SectionType = Section<String>
    
    private(set) var sections = [
        Section(items: ["Item 0.0", "Item 0.1", "Item 0.2"], headerTitle: "Header 0", footerTitle: "Footer 0"),
        Section(items: ["Item 1.0", "Item 1.1", "Item 1.2"], headerTitle: "Header 1", footerTitle: "Footer 1"),
        Section(items: ["Item 2.0", "Item 2.1", "Item 2.2"], headerTitle: "Header 2", footerTitle: "Footer 2")
    ]
    
    var reloadBlock: ReloadBlock?
}
