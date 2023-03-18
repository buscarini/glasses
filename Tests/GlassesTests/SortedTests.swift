import Foundation
import Glasses
import XCTest

class SortedTests: XCTestCase {
	func testSorted() {
		let people = Lens {
			\Company.employees
		}
		
		let byAge = Sorted {
			people
		} by: {
			\Person.age
		}
		
		let peopleByAge = byAge.get(company)
		
		dump(peopleByAge)
		
		XCTAssertEqual(
			peopleByAge,
			[
				mike,
				jessica,
				louis
			]
		)
		
		let modified = byAge.setting(company, to: [
			joe,
			mike,
			jessica,
			louis
		])
			
		XCTAssertEqual(
			byAge.get(modified),
			[
				joe,
				mike,
				jessica,
				louis
			]
		)
	}
}
