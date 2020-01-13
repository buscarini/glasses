
import Foundation
import XCTest
import glasses

class TraversalTests: XCTestCase {

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
			Person(id: "1", name: theName),
			Person(id: "2", name: otherName),
			Person(id: "3", name: theName),
		]
	}
	
	// MARK: Array
    func testGetArray() {
		XCTAssertEqual(TraversalTests.examples |> get(_map()), TraversalTests.examples)
    }

    func testSetArray() {
		let newPerson = Person(id: "-99", name: "Replacement")
		
		let res = TraversalTests.examples
			|> set(_map())(newPerson)

		XCTAssertEqual(res.count, 3)
		XCTAssertEqual(res[0].id, newPerson.id)
		XCTAssertEqual(res[0].name, newPerson.name)
		XCTAssertEqual(res[1].id, newPerson.id)
		XCTAssertEqual(res[1].name, newPerson.name)
		XCTAssertEqual(res[2].id, newPerson.id)
		XCTAssertEqual(res[2].name, newPerson.name)
    }
	
	func testGet() {
		XCTAssertEqual(TraversalTests.examples |> get(_map() <<< prop(\Person.name)), [TraversalTests.theName, TraversalTests.otherName, TraversalTests.theName])
    }


    func testSet() {
		let res = TraversalTests.examples
			|> set(_map() <<< prop(\Person.name))("Pepe")

		XCTAssertEqual(res.count, 3)
		XCTAssertEqual(res[0].id, "1")
		XCTAssertEqual(res[0].name, "Pepe")
		XCTAssertEqual(res[1].id, "2")
		XCTAssertEqual(res[1].name, "Pepe")
		XCTAssertEqual(res[2].id, "3")
		XCTAssertEqual(res[2].name, "Pepe")
    }
}

