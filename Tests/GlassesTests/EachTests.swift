import Foundation
import XCTest
import Glasses

class EachTests: XCTestCase {
	func testEach() {
		let people = Lens {
			\Company.employees
//			\Company.freelance
		}

		var uppercased = company
		
		let namesExceptFirst = Each {
			Lens {
				people.droppingFirst(1)
				\Person.name
			}
		}
		
		uppercased = namesExceptFirst.updateAll(uppercased, { $0.uppercased() })
		
		XCTAssertEqual(
			namesExceptFirst.getAll(uppercased),
			[ "LOUIS", "JESSICA" ]
		)
		
		let names = Each {
			Lens {
				people
				\Person.name
			}
		}
		
		XCTAssertEqual(
			names.getAll(uppercased),
			[ "Mike", "LOUIS", "JESSICA" ]
		)
	}
}
