import Foundation
import Glasses
import XCTest

class LensTests: XCTestCase {
	func testLens() {
		let ceoAge = Lens {
			\Company.ceo
			\Person.age
		}
		
		XCTAssertEqual(
			ceoAge.get(company),
			50
		)
		
		ceoAge.update(&company, { $0 += 1 })
		
		XCTAssertEqual(
			ceoAge.get(company),
			51
		)
	}
	
	func testArrayProperty() {
		let people = Concat {
			\Company.employees
			\Company.freelance
		}

		let names = Lens {
			people
			\Person.name
		}

		dump(
			names.get(company)
		)
		
		XCTAssertEqual(
			names.get(company),
			[ "Mike", "Louis", "Jessica", "John", "Joe", "Mike" ]
		)
	}
}
