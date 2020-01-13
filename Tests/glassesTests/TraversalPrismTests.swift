import XCTest
import glasses


class TraversalPrismTests: XCTestCase {

	static let theName = "Pepe"
	static let otherName = "Antonio"
	
	static let value = "Blah"

	struct Person: Equatable {
		var id: String
		var name: String
		
		static func == (_ left: Person, _ right: Person) -> Bool {
			return left.id == right.id && left.name == right.name
		}
	}
	
	static var examples: [Person] {
		return [
			Person(id: "1", name: otherName),
			Person(id: "2", name: theName),
			Person(id: "3", name: theName),
			Person(id: "4", name: otherName)
		]
	}
	
    // MARK: First
	func testGetArrayFirstWhere() {
		let value: Person? = TraversalPrismTests.examples
			|> get(_first(where: \Person.name, equals: TraversalPrismTests.theName))

		XCTAssertEqual(value?.id, "2")
		XCTAssertEqual(value?.name, PrismTests.person1.name)
    }
	
	func testSetArrayFirstWhere() {
		let people = TraversalPrismTests.examples
		let modified = people
			|> set(_first(where: \.name, equals: TraversalPrismTests.theName) <<< prop(\.name))(TraversalPrismTests.value)

		XCTAssertEqual(modified[0].id, "1")
		XCTAssertEqual(modified[0].name, TraversalPrismTests.otherName)
		
		XCTAssertEqual(modified[1].id, "2")
		XCTAssertEqual(modified[1].name, TraversalPrismTests.value)
		
		XCTAssertEqual(modified[2].id, "3")
		XCTAssertEqual(modified[2].name, TraversalPrismTests.theName)
		
		XCTAssertEqual(modified[3].id, "4")
		XCTAssertEqual(modified[3].name, TraversalPrismTests.otherName)
    }
	
    // MARK: Last
	func testGetArrayLastWhere() {
		let value: Person? = TraversalPrismTests.examples
			|> get(_last(where: \.name, equals: TraversalPrismTests.theName))

		XCTAssertEqual(value?.id, "3")
		XCTAssertEqual(value?.name, PrismTests.person1.name)
    }
	
	func testSetArrayLastWhere() {
		let people = TraversalPrismTests.examples
		let modified = people
			|> set(_last(where: \.name, equals: TraversalPrismTests.theName) <<< prop(\.name))(TraversalPrismTests.value)

		XCTAssertEqual(modified[0].id, "1")
		XCTAssertEqual(modified[0].name, TraversalPrismTests.otherName)
		
		XCTAssertEqual(modified[1].id, "2")
		XCTAssertEqual(modified[1].name, TraversalPrismTests.theName)
		
		XCTAssertEqual(modified[2].id, "3")
		XCTAssertEqual(modified[2].name, TraversalPrismTests.value)
		
		XCTAssertEqual(modified[3].id, "4")
		XCTAssertEqual(modified[3].name, TraversalPrismTests.otherName)
    }
}

