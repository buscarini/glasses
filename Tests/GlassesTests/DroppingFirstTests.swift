import Foundation
import XCTest
import Glasses

class DroppingFirstTests: XCTestCase {
	func testDroppingFirst() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}
		
		XCTAssertEqual(
			people
				.droppingFirst(1)
				.get(company),
			[ louis, jessica, john, joe, mike ]
		)
		
		XCTAssertEqual(
			people
				.droppingFirst(5)
				.get(company),
			[ mike ]
		)
		
		XCTAssertEqual(
			people
				.droppingFirst(20)
				.get(company),
			[ ]
		)
	}
}
