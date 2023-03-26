import Foundation
import Glasses
import XCTest

class FilterTests: XCTestCase {
	func testFilter() {
		let odd = Map {
			Filter {
				$0.0 % 2 == 0
			} with: {
				Each {
					Enumerated {
						\Company.freelance
					}
				}
			}
		} to: {
			$0.1
		} from: { original, updated in
			(original.0, updated)
		}
 		
		XCTAssertEqual(
			odd.getAll(company),
			[ john, mike ]
		)
		
		var local = company
		local = odd.updateAll(local, { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		})
		
		let oddNames = Many {
			odd
			\Person.name
		}

		XCTAssertEqual(
			oddNames.getAll(
				oddNames.updatingAll(company, { name in
					name = name.uppercased()
				})
			),
			[ "JOHN", "MIKE" ]
		)
	}
}
