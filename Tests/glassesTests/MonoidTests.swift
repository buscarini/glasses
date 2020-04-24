//
//  MonoidTests.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 24/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation
import XCTest
import glasses

class MonoidTests: XCTestCase {
	func testSum() {
		XCTAssertEqual(
			[].reduced(Monoid.sum),
			0
		)
		
		XCTAssertEqual(
			[1, 2, 3, 4, 5].reduced(Monoid.sum),
			15
		)
	}

	func testProduct() {
		XCTAssertEqual(
			[].reduced(Monoid.product),
			1
		)
		
		XCTAssertEqual(
			[1, 2, 3, 4, 5].reduced(Monoid.product),
			120
		)
	}
	
	func testAny() {
		XCTAssertEqual(
			[].reduced(Monoid.any),
			false
		)
		
		XCTAssertEqual(
			[true, false, true, false].reduced(Monoid.any),
			true
		)
		
		XCTAssertEqual(
			[ false, false].reduced(Monoid.any),
			false
		)
	}
	
	func testAll() {
		XCTAssertEqual(
			[].reduced(Monoid.all),
			true
		)
		
		XCTAssertEqual(
			[true, false, true, false].reduced(Monoid.all),
			false
		)
		
		XCTAssertEqual(
			[ true, true ].reduced(Monoid.all),
			true
		)
	}
	
	func testArray() {
		XCTAssertEqual(
			[].reduced(Monoid<[Int]>.array),
			[]
		)
		
		XCTAssertEqual(
			[[1, 2], [3, 4, 5]].reduced(Monoid.array),
			[1, 2, 3, 4, 5]
		)
	}
	
	func testFunc() {
		let m = Monoid<String>.func(Monoid<Int>.sum)
		
		XCTAssertEqual(
			[].reduced(m)("hello"),
			0
		)
		
		XCTAssertEqual(
			[
				{ $0.count },
				{ $0.filter { $0 == "l" }.count }
			].reduced(m)("hello"),
			7
		)
	}
}
