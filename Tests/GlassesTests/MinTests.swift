import Foundation
import Glasses
import XCTest

class MinTests: XCTestCase {
	func testMin() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}
		
		let oldest = Min {
			people
		} by: {
			\Person.age
		}
		
		XCTAssertEqual(
			oldest.tryGet(company),
			joe
		)
	}
}
