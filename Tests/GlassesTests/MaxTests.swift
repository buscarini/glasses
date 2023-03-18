import Foundation
import Glasses
import XCTest

class MaxTests: XCTestCase {
	func testMax() {
		let people = Lens {
			\Company.employees
		}
		
		let oldest = Max {
			people
		} by: {
			\Person.age
		}
		
		XCTAssertEqual(
			oldest.tryGet(company),
			louis
		)
		
		let oldestName = Optionally {
			oldest
			\Person.name
		}
		
		var local = company
		
		oldestName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			oldestName.tryGet(local),
			"LOUIS"
		)
		
		oldest.trySet(&local, to: mike)
		
		XCTAssertEqual(
			oldestName.tryGet(local),
			"Jessica"
		)
	}
}
