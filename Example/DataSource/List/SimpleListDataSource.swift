//
//  SimpleListDataSource.swift
//  DataSource
//
//  Created by Brad Smith on 2/3/17.
//  Copyright © 2017 ezCater. All rights reserved.
//

import EZDataSource
import Foundation

class SimpleListDataSource: ListDataSource {
    typealias ItemType = String

    private(set) var items = [
        "Item 0",
        "Item 1",
        "Item 2"
    ]

    var reloadBlock: ReloadBlock?
}
