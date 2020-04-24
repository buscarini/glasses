//
//  FoldTests.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation
import Foundation
import XCTest
import glasses

class FoldTests: XCTestCase {
	struct Person: Equatable {
		var id: String
		var name: String
		var fields: [String]
	}
	
	func testOptional() {
		let int: Int? = 3
		let none: Int? = nil
		
		let values = int
			|> get(Int?.fold())
		
		XCTAssertEqual(values.count, 1)
		XCTAssertEqual(values.first, 3)
		
		let empty = none
			|> get(Int?.fold())
		
		XCTAssertEqual(empty.count, 0)
	}
}
