import Foundation
import Glasses
import XCTest

class MaxTests: XCTestCase {
	func testMax() {
		let people = Concat {
			\Company.employees
			\Company.freelance
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
	}
}
