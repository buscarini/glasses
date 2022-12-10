import Foundation
import Glasses
import XCTest

class LensTests: XCTestCase {
	func testLens() {
		var local = company
		
		let ceoAge = Lens {
			\Company.ceo
			\Person.age
		}
		
		XCTAssertEqual(
			ceoAge.get(local),
			50
		)
		
		ceoAge.update(&local, { $0 += 1 })
		
		XCTAssertEqual(
			ceoAge.get(local),
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
