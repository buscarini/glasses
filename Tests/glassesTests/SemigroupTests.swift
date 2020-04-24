//
//  SemigroupTests.swift
//  TYRSharedUtilsTests
//
//  Created by José Manuel Sánchez Peñarroja on 30/03/2020.
//  Copyright © 2020 Tyris. All rights reserved.
//

import Foundation
import XCTest
import glasses

class SemigroupTests: XCTestCase {
	func testFirst() {
		XCTAssertEqual(
			[1, 2, 3, 4, 5].reduced(0, Semigroup.first),
			0
		)
	}
	
	func testLast() {
		XCTAssertEqual(
			[1, 2, 3, 4, 5].reduced(0, Semigroup.last),
			5
		)
	}
	
	func testLift() {
		XCTAssert(
			[].reduced(Semigroup.last.lift()) == nil
		)
		
		XCTAssertEqual(
			[1, 2, 3, 4, 5].reduced(Semigroup.last.lift()),
			5
		)
	}
}
