import Foundation
import Glasses
import XCTest
import CasePaths

class AnyOfTests: XCTestCase {
	enum State<A> {
		case ready
		case loadedLocal(A)
		case loadedRemote(A)
	}
	
	func testAnyOf() {
		let optic = AnyOf {
			/State<Int>.loadedLocal
			/State<Int>.loadedRemote
		}
		
		let local = State<Int>.loadedLocal(7)
		let remote = State<Int>.loadedLocal(14)
		
		XCTAssertEqual(
			optic.tryGet(local),
			7
		)
		
		XCTAssertEqual(
			optic.tryGet(remote),
			14
		)
		
		XCTAssertEqual(
			optic.tryGet(
				optic.trySetting(local, to: 12)
			),
			12
		)
		
		XCTAssertEqual(
			optic.tryGet(
				optic.trySetting(remote, to: 20)
			),
			20
		)
	}
}
