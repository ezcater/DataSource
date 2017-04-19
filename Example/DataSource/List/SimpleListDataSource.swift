//
//  SimpleListDataSource.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import Foundation
import DataSource

class SimpleListDataSource: ListDataSource {
    typealias ItemType = String
    
    fileprivate(set) var items = [
        "Item 0",
        "Item 1",
        "Item 2"
    ]
    
    var reloadBlock: ReloadBlock?
}
