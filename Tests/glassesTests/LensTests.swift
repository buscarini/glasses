
import XCTest
import glasses

class LensTests: XCTestCase {
	
	static let theName = "Pepe"
	static let otherName = "Antonio"
	
	struct Person {
		var name: String
	}
	
	static var example: Person {
		return Person(name: theName)
	}
	
	func testGet() {
		let lens = prop(\Person.name)
		
		XCTAssertEqual(get(lens, LensTests.example), LensTests.theName)
	}
	
	func testSet() {
		let lens = prop(\Person.name)
		
		let res = LensTests.example
			|> set(lens, LensTests.otherName)
			|> get(lens)
		
		XCTAssertEqual(res, LensTests.otherName)
	}
	
	func testTuple() {
		let res = get(_1(), (LensTests.example, "Pepe"))
		
		XCTAssertEqual(res, "Pepe")
	}
	
	func testChangeType() {
		let res: Int = (LensTests.example, "Pepe")
			|> update(_1()) { $0.count }
			|> get(_1())
		
		XCTAssertEqual(res, 4)
	}
}

