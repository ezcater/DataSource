# DataSource

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org)

DataSource is a concise and UI independent protocol for representing data sources. It can be used out of the box, but is also extremely flexible in case any customization is required.

At it's core, `DataSource` is a simple protocol. It requires a `ItemType`, which represents the type of the contained objects.

```swift
public protocol DataSource {
    associatedtype ItemType

    var reloadBlock: ReloadBlock? { get set }
    var numberOfSections: Int { get }
    
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> ItemType?
    func indexPath(after indexPath: IndexPath) -> IndexPath?
}
```

It uses a closure, `ReloadBlock`, to communicate a `ChangeSet` in the backing data.

```swift
public typealias ReloadBlock = (ChangeSet) -> Void
```

A `ChangeSet` is a set of `Change`s to be performed to the corresponding UI element (`UITableView` or `UICollectionView`).

```swift
public enum ChangeSet {
    case some([Change])
    case all
}

public enum Change {
    case section(type: ChangeType)
    case object(type: ChangeType)
}

public enum ChangeType {
    case insert(IndexPath)
    case delete(IndexPath)
    case move(IndexPath, IndexPath)
    case update(IndexPath)
}
```

## ListDataSource

`ListDataSource` inherits from `DataSource` and represents a single section backed by an array.
    
```swift
public protocol ListDataSource: DataSource {
    var items: [ItemType] { get }
}
```

It includes default implementations for:

- `var numberOfSections: Int`
- `func numberOfItems(in section: Int) -> Int`
- `func item(at indexPath: IndexPath) -> ItemType?`
- `func indexPath(after indexPath: IndexPath) -> IndexPath?`

#### Example

```swift
class SimpleDataSource: ListDataSource {
    typealias ItemType = String
    
    var items = [
        "Item 0",
        "Item 1",
        "Item 2"
    ]
    
    var reloadBlock: ReloadBlock?
}
```

## SectionedDataSource

`SectionedDataSource` inherits from `DataSource` and represents multiple sections, each backed by a `Section`.

```swift
public protocol SectionedDataSource: DataSource {
    associatedtype SectionType: Section<ItemType>
    
    var sections: [SectionType] { get }
    
    func headerTitle(for section: Int) -> String?
    func footerTitle(for section: Int) -> String?
}
```

It includes default implementations for:

- `var numberOfSections: Int`
- `func numberOfItems(in section: Int) -> Int`
- `func item(at indexPath: IndexPath) -> ItemType?`
- `func indexPath(after indexPath: IndexPath) -> IndexPath?`
- `func headerTitle(for section: Int) -> String?`
- `func footerTitle(for section: Int) -> String?`

#### Example

```swift
class SimpleDataSource: SectionedDataSource {
    typealias ItemType = String
    typealias SectionType = Section<String>
    
    var sections = [
        Section(items: ["Item 0.0", "Item 0.1", "Item 0.2"]),
        Section(items: ["Item 1.0", "Item 1.1"], headerTitle: "Header 1"),
        Section(items: ["Item 2.0"], headerTitle: "Header 2", footerTitle: "Footer 2")
    ]
    
    var reloadBlock: ReloadBlock?
}
```

## Section

`Section` objects each represent a single section. It includes an array of `ItemType` items and optionally a header or footer title. It is subclassable if  any additional functionality is needed.

```swift
open class Section<ItemType> {
    public var items: [ItemType]
    public var headerTitle: String?
    public var footerTitle: String?
    
    public init(items: [ItemType], headerTitle: String? = nil, footerTitle: String? = nil) {
        self.items = items
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}
```

## FetchedDataSource

`FetchedDataSource` inherits from `DataSource` and represents a `NSFetchResultsController` backed list.

```swift
public protocol FetchedDataSource: DataSource {
    associatedtype ItemType: NSFetchRequestResult
    
    var fetchedResultsController: NSFetchedResultsController<ItemType> { get }
}
```

It includes default implementations for:

- `var numberOfSections: Int`
- `func numberOfItems(in section: Int) -> Int`
- `func item(at indexPath: IndexPath) -> ItemType?`
- `func indexPath(after indexPath: IndexPath) -> IndexPath?`

## Requirements

DataSource requires Swift 3.0 and iOS 8.0+

## Installation

DataSource is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DataSource"
```

## Author

Brad Smith, bradley.d.smith11@gmail.com

## License

DataSource is available under the MIT license. See the LICENSE file for more info.
