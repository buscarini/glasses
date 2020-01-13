
import XCTest
import glasses


class PrismTests: XCTestCase {

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

	enum Result<A> {
		case success(A)
		case failure
		
		static func _success<B>() -> Prism<Result<A>, A, B, Result<B>> {
			return Prism(get: { r in
				switch r {
					case .success(let a):
						return a
					case .failure:
						return nil
				}
			}, update: { f in
				{ (r: Result<A>) -> Result<B> in
					switch r {
						case .success(let a):
							return Result<B>.success(f(a))
						case .failure:
							return Result<B>.failure
					}
				}
			})
		}
	}
	
	static var example: Result<String> {
		return Result.success(PrismTests.value)
	}
	
	static var failure: Result<String> {
		return Result.failure
	}
	
	static var person1: Person {
		return Person(name: PrismTests.value)
	}
	
	static var person2: Person {
		return Person(name: PrismTests.value2)
	}
	
	static var person3: Person {
		return Person(name: PrismTests.value3)
	}
	
	static var people: [Person] {
		return [
			person1,
			Person(name: "another"),
			person3,
			person2
		]
	}

	// MARK: Optional
    func testGetOptional() {
		let value: String? = PrismTests.value
			|> get(_some())

		XCTAssertEqual(value, PrismTests.value)
    }

    func testSetOptional() {
		let value = PrismTests.value
			|> set(_some())(PrismTests.otherValue)
			|> get(_some())
		
		XCTAssertEqual(value, PrismTests.otherValue)
		
		let name: String? = nil
		let value2 = name
			|> set(_some())(PrismTests.otherValue)
			|> get(_some())
		
		XCTAssertEqual(value2, nil)
    }

	// MARK: Result
    func testGetResult() {
		let value: String? = PrismTests.example
			|> get(Result._success())

		XCTAssertEqual(value, PrismTests.value)
    }
	
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

    func testSetResult() {
		let value = PrismTests.example
			|> set(Result._success())(PrismTests.otherValue)
			|> get(Result._success())
		
		XCTAssertEqual(value, PrismTests.otherValue)
    }
	
	// MARK: Array
	func testGetArrayFirst() {
		let value: Person? = PrismTests.people
			|> get(_first())

		XCTAssertEqual(value, PrismTests.person1)
    }

    func testSetArrayFirst() {
		let firstName = _first() <<< prop(\Person.name)
		
       	let changed = "Juan"
		let value: String? = PrismTests.people
			|> set(firstName)(changed)
			|> get(firstName)

		XCTAssertEqual(value, changed)
    }

	func testGetArrayLast() {
		let value: Person? = PrismTests.people
			|> get(_last())

		XCTAssertEqual(value, PrismTests.person2)
    }
	
    func testSetArrayLast() {
		let lastName = _last() <<< prop(\Person.name)
		
       	let changed = "Juan"
		let value: String? = PrismTests.people
			|> set(lastName)(changed)
			|> get(lastName)

		XCTAssertEqual(value, changed)
    }
	
    func testGetArrayThird() {
		let value: Person? = PrismTests.people
			|> get(_index(2))

		XCTAssertEqual(value, PrismTests.person3)
    }
	
    func testSetArrayThird() {
       	let changed = "Juan"
		let value: String? = PrismTests.people
			|> set(_index(2) <<< prop(\.name))(changed)
			|> get(_index(2) <<< prop(\.name))

		XCTAssertEqual(value, changed)
    }
	
    func testGetDic() {
		
		let dic = [ PrismTests.value: 1, PrismTests.value2: 2 ]
		
		XCTAssertEqual(dic |> get(_value(key: PrismTests.value)), 1)
		XCTAssertEqual(dic |> get(_value(key: PrismTests.value2)), 2)
    }
	
    func testSetDic() {
		
		let dic = [ PrismTests.value: 1, PrismTests.value2: 2 ]
			|> set(_value(key: PrismTests.value), 7)
		
		XCTAssertEqual(dic |> get(_value(key: PrismTests.value)), 7)
		XCTAssertEqual(dic |> get(_value(key: PrismTests.value2)), 2)
    }
}


