
import XCTest
import glasses

class LensCompositionTests: XCTestCase {

	static let number1 = 1
	static let number2 = 22

	struct Street {
		var number: Int
	}

	struct Address {
		var city: String
		var street: Street
	}

	struct Person {
		var name: String
		var address: Address
	}
	
	// MARK: Examples
	static var exampleStreet: Street {
		return Street(number: number1)
	}
	
	static var exampleAddress: Address {
		return Address(city: "Valencia", street: LensCompositionTests.exampleStreet)
	}
	
	static var examplePerson: Person {
		return Person(name: "Pepe", address: LensCompositionTests.exampleAddress)
	}
	
    func testGet() {
		let number = LensCompositionTests.examplePerson
			|> get(prop(\.address) <<< prop(\.street) <<< prop(\.number))
		
		XCTAssertEqual(number, LensCompositionTests.number1)
    }
	
	func testUpdate() {
		let person = LensCompositionTests.examplePerson
			|> update(prop(\.address) <<< prop(\.street) <<< prop(\.number)) { $0 + 1 }
		
		XCTAssertEqual(person.address.street.number, LensCompositionTests.number1 + 1)
	}
	
	func testSet() {
		
		let lens = prop(\Person.address) <<< prop(\.street) <<< prop(\.number)
		
		let number = LensCompositionTests.examplePerson
			|> set(lens, LensCompositionTests.number2)
			|> get(lens)
		
		XCTAssertEqual(number, LensCompositionTests.number2)
    }
	
    func testChangeType() {

		let number = (LensCompositionTests.examplePerson, 1)
			|> set(_0(), LensCompositionTests.number2)
			|> get(_0())

		XCTAssertEqual(number, LensCompositionTests.number2)
    }
	
    func testGetKeyPath() {
		let number = LensCompositionTests.examplePerson
			|> get(\.address.street.number)
		
		XCTAssertEqual(number, LensCompositionTests.number1)
    }
	
    func testUpdateKeyPath() {
		let person = LensCompositionTests.examplePerson
			|> update(\.address.street.number) { $0 + 1 }
		
		XCTAssertEqual(person.address.street.number, LensCompositionTests.number1 + 1)
	}
	
	func testSetKeyPath() {
		
		let path = \Person.address.street.number
		
		let number = LensCompositionTests.examplePerson
			|> set(path, LensCompositionTests.number2)
			|> get(path)
		
		XCTAssertEqual(number, LensCompositionTests.number2)
    }
}


