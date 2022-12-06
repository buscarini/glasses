import Foundation
import XCTest
import Glasses

class EachTests: XCTestCase {
	func testEach() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}

		var uppercased = company
		
		let names = Each {
			Lens {
				people.droppingFirst(1)
				\Person.name
			}
		}
		
		names.updateAll(&uppercased, { $0 = $0.uppercased() })
		
		XCTAssertEqual(
			names.getAll(uppercased),
			[ "LOUIS", "JESSICA", "JOHN", "JOE", "MIKE" ]
		)
	}
}
