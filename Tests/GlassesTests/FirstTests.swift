import Foundation
import Glasses
import XCTest

class FirstTests: XCTestCase {
	func testFirst() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}
		
		let first = First {
			people
		}
		
		XCTAssertEqual(
			first.tryGet(company),
			mike
		)
		
		let firstName = Optionally {
			first
			\Person.name
		}
		
		var local = company
		
		firstName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			firstName.tryGet(local),
			"MIKE"
		)
	}
}
