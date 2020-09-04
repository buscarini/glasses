import XCTest
import glasses


class TraversalCompositionTests: XCTestCase {

	static let number1 = 1
	static let number2 = 22
	static let number3 = 3

	struct Street {
		var number: Int
	}

	struct Address {
		var city: String
		var streets: [Street]
	}

	struct Person {
		var name: String
		var addresses: [Address]
	}
	
	// MARK: Examples
	static var exampleStreets: [Street] {
		return [
			Street(number: number1),
			Street(number: number2)
		]
	}
	
	static var exampleAddresses: [Address] {
		return [
			Address(city: "Valencia", streets: TraversalCompositionTests.exampleStreets),
			Address(city: "Castellon", streets: TraversalCompositionTests.exampleStreets)
		]
	}
	
	static var examplePerson: Person {
		return Person(name: "Pepe", addresses: TraversalCompositionTests.exampleAddresses)
	}
	
//    func testGet() {
//		let numbers = TraversalCompositionTests.examplePerson
//			|> get(prop(\Person.addresses).traversal()
//				<<< prop(\Address.streets).traversal()
//				<<< _map()
//				<<< prop(\Street.number).traversal()
//		)
//
//		XCTAssertEqual(numbers, [
//			TraversalCompositionTests.number1,
//			TraversalCompositionTests.number2,
//			TraversalCompositionTests.number1,
//			TraversalCompositionTests.number2
//		])
//    }
	
//    private var streetNumbers: Traversal<TraversalCompositionTests.Person, Int, Int, TraversalCompositionTests.Person> {
//		let tmp = prop(\Person.addresses).traversal()
//			<<< prop(\Address.streets).traversal()
//			<<< _map()
//			<<< prop(\Street.number).traversal()
//			
//	}
	
//	func testUpdate() {
//		let numbers = TraversalCompositionTests.examplePerson
//			|> update(streetNumbers) { $0 + 1 }
//			|> get(streetNumbers)
//
//		XCTAssertEqual(numbers, [
//			TraversalCompositionTests.number1,
//			TraversalCompositionTests.number2,
//			TraversalCompositionTests.number1,
//			TraversalCompositionTests.number2
//		].map { $0+1 })
//	}

//	func testSet() {
////		let streetNumbers = (\Person.addresses <<< Array.map() <<< \Address.streets <<< Array.map() <<< \Street.number)
//
//		let numbers = TraversalCompositionTests.examplePerson
//			|> set(streetNumbers)(TraversalCompositionTests.number3)
//			|> get(streetNumbers)
//
//		XCTAssertEqual(numbers, [
//			TraversalCompositionTests.number3,
//			TraversalCompositionTests.number3,
//			TraversalCompositionTests.number3,
//			TraversalCompositionTests.number3
//		])
//	}
}



