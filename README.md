# DataSource

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org)
[![Version](https://img.shields.io/cocoapods/v/DataSource.svg?style=flat)](http://cocoapods.org/pods/DataSource)
[![License](https://img.shields.io/cocoapods/l/DataSource.svg?style=flat)](http://cocoapods.org/pods/DataSource)
[![Platform](https://img.shields.io/cocoapods/p/DataSource.svg?style=flat)](http://cocoapods.org/pods/DataSource)

DataSource is a concise and UI independent protocol for representing data sources. It can be used out of the box, but is also extremely flexible in case any customization is required.

At it's core, `DataSource` is a simple protocol. It requires a `ModelType`, which represents the type of the contained objects. It also requires a way to retrieve the section count, item count in a section, and an item at a specified index path.

```swift
public protocol DataSource {
    associatedtype ModelType

    var reloadBlock: ReloadBlock? { get set }
    var numberOfSections: Int { get }
    
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> ModelType?
}
```

It uses a closure, `ReloadBlock`, to communicate changes in the backing data. The intended usage is to pass an array of dirty index paths or an empty array to signify that all index paths should be reloaded.

```swift
public typealias ReloadBlock = ([IndexPath]) -> Void
```

## ListDataSource

`ListDataSource` inherits from `DataSource` and represents a single section backed by an array.
    
```swift
public protocol ListDataSource: DataSource {
    var items: [ModelType] { get }
}
```

It includes default implementations for:

- `var numberOfSections: Int`
- `func numberOfItems(in section: Int) -> Int`
- `func item(at indexPath: IndexPath) -> ModelType?`

#### Example

```swift
class SimpleDataSource: ListDataSource {
    typealias ModelType = String
    
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
    associatedtype SectionType: Section<ModelType>
    
    var sections: [SectionType] { get }
    
    func headerTitle(for section: Int) -> String?
    func footerTitle(for section: Int) -> String?
}
```

It includes default implementations for:

- `var numberOfSections: Int`
- `func numberOfItems(in section: Int) -> Int`
- `func item(at indexPath: IndexPath) -> ModelType?`
- `func headerTitle(for section: Int) -> String?`
- `func footerTitle(for section: Int) -> String?`

#### Example

```swift
class SimpleDataSource: SectionedDataSource {
    typealias ModelType = String
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

`Section` objects each represent a single section. It includes an array of `ModelType` items and optionally a header or footer title. It is subclassable if  any additional functionality is needed.

```swift
open class Section<ModelType> {
    public var items: [ModelType]
    public var headerTitle: String?
    public var footerTitle: String?
    
    public init(items: [ModelType], headerTitle: String? = nil, footerTitle: String? = nil) {
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
    associatedtype ModelType: NSFetchRequestResult
    
    var fetchedResultsController: NSFetchedResultsController<ModelType> { get }
}
```

It includes default implementations for:

- `var numberOfSections: Int`
- `func numberOfItems(in section: Int) -> Int`
- `func item(at indexPath: IndexPath) -> ModelType?`


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
