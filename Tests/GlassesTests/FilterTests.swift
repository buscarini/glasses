import Foundation
import Glasses
import XCTest

//class FilterTests: XCTestCase {
//	func testFilter() {
//		let odd = Filter {
//			$0.0 % 2 != 0
//		} with: {
//			Each {
//				Enumerated {
//					\Company.freelance
//				}
//			}
//		}
// 		
//		XCTAssertEqual(
//			odd.getAll(company),
//			[ john, mike ]
//		)
//		
//		let oddNames = Many {
//			odd
//			\Person.name
//		}
//
//		XCTAssertEqual(
//			odd.getAll(
//				oddNames.updatingAll(company, { name in
//					name = name.uppercased()
//				})
//			),
//			[ john, mike ]
//		)
//	}
//}
