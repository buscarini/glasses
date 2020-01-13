//
//  IsoTests.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 13/01/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation
import XCTest
import glasses

class IsoTests: XCTestCase {
	
	// MARK: Numeric
	func testNegated() {
		XCTAssert(get(negated(), 1) == -1)
		XCTAssert(set(negated(), 5, 1) == -5)
		
		XCTAssert(get(adding(5), 1) == 6)
		XCTAssert(set(adding(5), 6, 0) == 1)
	}
	
	func testComposition() {
		let iso = negated() >>> adding(5)
		
		XCTAssertEqual(get(iso, 9), -14)
		XCTAssertEqual(set(iso, 6, 0), -11)
	}
}
