import Foundation
import Glasses
import XCTest

class AtTests: XCTestCase {
	func testAt() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}
		
		let fourth = At(3) {
			people
		}
		
		XCTAssertEqual(
			fourth.tryGet(company),
			john
		)
		
		let fourthName = Optionally {
			fourth
			\Person.name
		}
		
		var local = company
		
		fourthName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			fourthName.tryGet(local),
			"JOHN"
		)
	}
}
