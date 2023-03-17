import Foundation
import XCTest
import Glasses
import CasePaths

class OptionallyTests: XCTestCase {
	func testOptionally() {
		let advisor = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}
		
		let advisorName = Optionally {
			advisor
			\Person.name
		}
				
		var local = company
		
		XCTAssertNil(advisorName.tryGet(local))

		advisorName.trySet(&local, to: "Joe")
		
		XCTAssertNil(advisorName.tryGet(local))
		
		advisor.trySet(&local, to: joe)

		XCTAssertEqual(
			advisor.tryGet(local),
			joe
		)
		
		advisorName.trySet(&local, to: "John")
		
		XCTAssertEqual(
			advisorName.tryGet(local),
			"John"
		)
	}
}
