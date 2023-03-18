import Foundation
import XCTest
import Glasses

class DroppingFirstTests: XCTestCase {
	func testDroppingFirst() {
		let people = Lens {
				\Company.employees
		}
		
		XCTAssertEqual(
			people
				.droppingFirst(1)
				.get(company),
			[ louis, jessica ]
		)
		
		XCTAssertEqual(
			people
				.droppingFirst(2)
				.get(company),
			[ jessica ]
		)
		
		XCTAssertEqual(
			people
				.droppingFirst(20)
				.get(company),
			[ ]
		)
		
		var updated = company
		
		people
			.droppingFirst()
			.set(&updated, to: [ john ])
		
		XCTAssertEqual(
			updated.employees[1],
			john
		)
	}
}
