import Foundation
import Glasses
import XCTest

class SortedTests: XCTestCase {
	func testSorted() {
		let people = Concat {
			\Company.employees
			\Company.freelance
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
				joe,
				mike,
				mike,
				jessica,
				john,
				louis
			]
		)
		
		let modified = byAge.setting(company, to: [
			joe,
			mike,
			mike,
			jessica,
			jessica,
			louis
		])
			
		XCTAssertEqual(
			byAge.get(modified),
			[
				joe,
				mike,
				mike,
				jessica,
				jessica,
				louis
			]
		)
		
//		let oldestName = Optionally {
//			oldest
//			\Person.name
//		}
//		
//		var local = company
//		
//		oldestName.tryUpdate(&local) { $0 = $0.uppercased() }
//		
//		XCTAssertEqual(
//			oldestName.tryGet(local),
//			"LOUIS"
//		)
//		
//		oldest.trySet(&local, to: mike)
//		
//		XCTAssertEqual(
//			oldestName.tryGet(local),
//			"John"
//		)
	}
}
