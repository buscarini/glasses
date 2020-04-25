//
//  Traversal1Tests.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 26/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation
import XCTest
import glasses

class Traversal1Tests: XCTestCase {
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
	
	static var person1: Person {
		return Person(name: Traversal1Tests.value)
	}
	
	static var person2: Person {
		return Person(name: Traversal1Tests.value2)
	}
	
	static var person3: Person {
		Person(name: Traversal1Tests.value3)
	}
	
	static var people: [Person] {
		[
			person1,
			Person(name: "another"),
			person3,
			person2
		]
	}
	
	// MARK: Array
	func testGetArrayFirst() {
		let value: Person? = Traversal1Tests.people
			|> get([Person]._first())
		
		XCTAssertEqual(value, Traversal1Tests.person1)
	}
	
	func testSetArrayFirst() {
		let firstName = [Person]._first() <<< prop(\Person.name).traversal1()
		
		let changed = "Juan"
		let value: String? = Traversal1Tests.people
			|> set_(firstName, changed)
			|> get(firstName)
		
		XCTAssertEqual(value, changed)
	}
	
	func testGetArrayLast() {
		let value: Person? = Traversal1Tests.people
			|> get([Person]._last())
		
		XCTAssertEqual(value, Traversal1Tests.person2)
	}
	
	func testSetArrayLast() {
		let lastName = [Person]._last() <<< prop(\Person.name).traversal1()
		
		let changed = "Juan"
		let value: String? = Traversal1Tests.people
			|> set_(lastName, changed)
			|> get(lastName)
		
		XCTAssertEqual(value, changed)
	}
	
	func testGetArrayThird() {
		let value: Person? = Traversal1Tests.people
			|> get([Person]._index(2))
		
		XCTAssertEqual(value, Traversal1Tests.person3)
	}
	
	func testSetArrayThird() {
		let changed = "Juan"
		let value: String? = Traversal1Tests.people
			|> set_([Person]._index(2) <<< prop(\.name).traversal1(), changed)
			|> get([Person]._index(2) <<< prop(\.name).traversal1())
		
		XCTAssertEqual(value, changed)
	}
	
	func testGetDic() {
		
		let dic = [ Traversal1Tests.value: 1, Traversal1Tests.value2: 2 ]
		
		XCTAssertEqual(dic |> get([String: Int]._value(key: Traversal1Tests.value)), 1)
		XCTAssertEqual(dic |> get([String: Int]._value(key: Traversal1Tests.value2)), 2)
	}
	
	func testSetDic() {
		
		let dic = [ Traversal1Tests.value: 1, Traversal1Tests.value2: 2 ]
			|> set_([String: Int]._value(key: Traversal1Tests.value), 7)
		
		XCTAssertEqual(dic |> get([String: Int]._value(key: Traversal1Tests.value)), 7)
		XCTAssertEqual(dic |> get([String: Int]._value(key: Traversal1Tests.value2)), 2)
	}
}
