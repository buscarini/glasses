import Foundation
import Glasses
import XCTest

class AtTests: XCTestCase {
	func testAt() {
		let people = Lens {
			\Company.employees
//			\Company.freelance
		}
		
		let person = At(2) {
			people
		}
		
		XCTAssertEqual(
			person.tryGet(company),
			jessica
		)
		
		let personName = Optionally {
			person
			\Person.name
		}
		
		var local = company
		
		personName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			personName.tryGet(local),
			"JESSICA"
		)
	}
}
