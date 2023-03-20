import Foundation
import Glasses
import XCTest

class EnumeratedTests: XCTestCase {
	func testEnumerated() {
		let lens = Enumerated {
			\Company.freelance
		}
		
		let enumerated = lens.get(company).map { index, element in (index, element)  }
		
		XCTAssertEqual(
			enumerated[0].0,
			0
		)
		
		XCTAssertEqual(
			enumerated[0].1,
			john
		)
		
		XCTAssertEqual(
			enumerated[1].0,
			1
		)
		
		XCTAssertEqual(
			enumerated[1].1,
			joe
		)
		
		XCTAssertEqual(
			enumerated[2].0,
			2
		)
		
		XCTAssertEqual(
			enumerated[2].1,
			mike
		)
		
		
		
	}
}
