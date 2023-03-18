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
			Each {
				\Company.employees
			}
			Each {
				\Company.freelance
			}
		}

		let names = Many {
			people
			\Person.name
		}

		dump(
			names.getAll(company)
		)
		
		XCTAssertEqual(
			names.getAll(company),
			[ "Mike", "Louis", "Jessica", "John", "Joe", "Mike" ]
		)
	}
}
