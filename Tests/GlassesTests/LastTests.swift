import Foundation
import Glasses
import XCTest

class LastTests: XCTestCase {
	func testLast() {
		let people = Concat {
			\Company.freelance
			\Company.employees
		}
		
		let last = Last {
			people
		}
		
		XCTAssertEqual(
			last.tryGet(company),
			jessica
		)
		
		let lastName = Optionally {
			last
			\Person.name
		}
		
		var local = company
		
		lastName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			lastName.tryGet(local),
			"JESSICA"
		)
	}
}
