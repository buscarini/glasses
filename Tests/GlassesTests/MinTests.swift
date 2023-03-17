import Foundation
import Glasses
import XCTest

class MinTests: XCTestCase {
	func testMin() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}
		
		let youngest = Min {
			people
		} by: {
			\Person.age
		}
		
		XCTAssertEqual(
			youngest.tryGet(company),
			joe
		)
		
		let youngestName = Optionally {
			youngest
			\Person.name
		}
		
		var local = company
		
		youngestName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			youngestName.tryGet(local),
			"JOE"
		)
	}
}
