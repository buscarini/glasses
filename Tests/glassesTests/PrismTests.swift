
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

	// MARK: Either
	func testGetEither() {
		let value: Int? = Either<Int, String>.left(2)
			|> extract(Either._left())
		
		XCTAssertEqual(value, 2)
		
		XCTAssertNil(
			Either<Int, String>.left(2) |> extract(Either._right())
		)
		
		let value2: String? = Either<Int, String>.right("hello")
			|> extract(Either._right())
		
		XCTAssertNil(
			Either<Int, String>.right("hello") |> extract(Either._left())
		)
		
		XCTAssertEqual(value2, "hello")
	}
	
	// MARK: Result
	func testGetResultPath() {
		let value: String? = PrismTests.example
			|> extract(/Result.success)
		
		XCTAssertEqual(value, PrismTests.value)
	}
	
	func testGetResult() {
		let value: String? = PrismTests.example
			|> extract(Result._success())
		
		XCTAssertEqual(value, PrismTests.value)
	}
	
	func testGetResultDefault() {
		let value: String? = PrismTests.failure
			|> get(Result._success().default(PrismTests.value2))
		
		XCTAssertEqual(value, PrismTests.value2)
	}
	
	func testGetResultWithDefault() {
		let value: String? = PrismTests.failure
			|> get(Result._success() |> withDefault(PrismTests.value2))
		
		XCTAssertEqual(value, PrismTests.value2)
	}
	
	func testEmbedResult() {
		let value = embed(Result<Int, Error>._success(), PrismTests.otherValue)
			|> extract(Result._success())
				
		XCTAssertEqual(value, PrismTests.otherValue)
	}
}


