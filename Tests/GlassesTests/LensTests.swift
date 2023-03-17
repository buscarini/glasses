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
		
		XCTAssertEqual(
			ceoAge.get(
				ceoAge.updating(local, { $0 += 1 })
			),
			52
		)
		
		XCTAssertEqual(
			ceoAge.get(
				ceoAge.setting(local, to: 22)
			),
			22
		)
	}
	
	func testConcat() {
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
