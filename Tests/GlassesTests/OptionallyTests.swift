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

		advisorName.trySet(&local, newValue: "Joe")
		
		XCTAssertNil(advisorName.tryGet(local))
		
		advisor.trySet(&local, newValue: joe)

		XCTAssertEqual(
			advisor.tryGet(local),
			joe
		)
		
		advisorName.trySet(&local, newValue: "John")
		
		XCTAssertEqual(
			advisorName.tryGet(local),
			"John"
		)
	}
}
