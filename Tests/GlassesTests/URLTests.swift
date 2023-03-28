import Foundation
import Glasses
import XCTest

class URLTests: XCTestCase {
	func testURL() {
		let url = URL(string: "https://www.google.com")!
				
		XCTAssertEqual(
			URL.schemeOptic().tryGet(url),
			"https"
		)
		
		XCTAssertEqual(
			URL.schemeOptic().trySet(url, to: "ftp").absoluteString,
			"ftp://www.google.com"
		)
		
		XCTAssertEqual(
			URL.hostOptic().tryGet(url),
			"www.google.com"
		)
		
		XCTAssertEqual(
			URL.hostOptic().trySet(url, to: "www.tyris-software.com").absoluteString,
			"https://www.tyris-software.com"
		)
	}
}
