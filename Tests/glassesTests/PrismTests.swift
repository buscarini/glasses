
import XCTest
import glasses

class PrismTests: XCTestCase {
	
	enum E: Error {
		case err
	}
	
	static let value = "Pepe"
	static let otherValue = 1
	static let value2 = "Antonio"
	
	static let value3 = "Another"
	
	struct Person: Equatable {
		var name: String
		
		static func == (lhs: Person, rhs: Person) -> Bool {
			return lhs.name == rhs.name
		}
	}
	
	static var example: Result<String, Error> {
		return Result.success(PrismTests.value)
	}
	
	static var failure: Result<String, Error> {
		return Result.failure(E.err)
	}
	
	// MARK: Optional
	//    func testGetOptional() {
	//		let value: String? = PrismTests.value
	//			|> get(some())
	//
	//		XCTAssertEqual(value, PrismTests.value)
	//    }
	
//	func testSetOptional() {
//		let value = embed(some(), PrismTests.otherValue)
//			|> get(some())
//		
//		XCTAssertEqual(value, PrismTests.otherValue)
//		
//		let name: String? = nil
//		let value2 = name
//			|> set(some())(PrismTests.otherValue)
//			|> get(some())
//		
//		XCTAssertEqual(value2, nil)
//	}
	
	// MARK: Result
//	func testGetResult() {
//		let value: String? = PrismTests.example
//			|> extract(Result._success())
//
//		XCTAssertEqual(value, PrismTests.value)
//	}
	
	//    func testGetResultDefault() {
	//		let value: String? = PrismTests.failure
	//			|> get(Result._success() |> _default(PrismTests.value2))
	//
	//		XCTAssertEqual(value, PrismTests.value2)
	//    }
	
	func testGetResultDefault() {
		let value: String? = PrismTests.failure
			|> get(Result._success() |> withDefault(PrismTests.value2))
		
		XCTAssertEqual(value, PrismTests.value2)
	}
	
//	func testEmbedResult() {
//		let value = embed(Result<Int, Error>._success(), PrismTests.otherValue)
//			|> extract(Result._success())
//		
////		let value = PrismTests.example
////			|> set(Result._success())(PrismTests.otherValue)
////			|> get(Result._success())
//		
//		XCTAssertEqual(value, PrismTests.otherValue)
//	}
}


