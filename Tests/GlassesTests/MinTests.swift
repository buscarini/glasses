import Foundation
import Glasses
import XCTest

class MinTests: XCTestCase {
	func testMin() {
		let people = Lens {
			\Company.employees
//			\Company.freelance
		}
		
		let youngest = Min {
			people
		} by: {
			\Person.age
		}
		
		XCTAssertEqual(
			youngest.tryGet(company),
			mike
		)
		
		let youngestName = Optionally {
			youngest
			\Person.name
		}
		
		var local = company
		
		youngestName.tryUpdate(&local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			youngestName.tryGet(local),
			"MIKE"
		)
		
		youngest.trySet(&local, to: louis)
		
		XCTAssertEqual(
			youngestName.tryGet(local),
			"Jessica"
		)
	}
}
