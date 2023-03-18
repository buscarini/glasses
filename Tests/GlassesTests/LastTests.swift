import Foundation
import Glasses
import XCTest

class LastTests: XCTestCase {
	func testLast() {
		let people = Lens {
			\Company.freelance
		}
		
		let last = Last {
			people
		}
		
		XCTAssertEqual(
			last.tryGet(company),
			mike
		)
		
		let lastName = Optionally {
			last
			\Person.name
		}
		
		var local = company
		
		lastName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			lastName.tryGet(local),
			"MIKE"
		)
	}
}
