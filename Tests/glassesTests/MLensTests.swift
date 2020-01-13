import UIKit
import XCTest
import glasses

//class MLensTests: XCTestCase {
//	
//	static let label: UILabel = {
//		return with(UILabel(),
//						mset(\UILabel.text, "Blah") <>
//							mset(\UILabel.backgroundColor, .white)
//		)
//	}()
//	
//	static let textField = UITextField()
//	
//	func testGet() {
//		let lens = mprop(\UILabel.backgroundColor)
//		
//		XCTAssertEqual(get(lens, MLensTests.label), .white)
//	}
//	
//	func testSet() {
//		var res = MLensTests.label
//		
//		let lens = mprop(\UILabel.backgroundColor)
//		
//		with(&res, mset(lens, .black))
//		
//		XCTAssertEqual(get(lens, res), .black)
//	}
//	
//	/*func testTuple() {
//	let res = get(_1(), (LensTests.example, "Pepe"))
//	
//	XCTAssertEqual(res, "Pepe")
//	}
//	
//	func testChangeType() {
//	let res: Int = (LensTests.example, "Pepe")
//	|> update(_1()) { $0.count }
//	|> get(_1())
//	
//	XCTAssertEqual(res, 4)
//	}
//	
//	func testEither() {
//	let left = Either<String, String>.left("Blah")
//	let right = Either<String, String>.right("Blah")
//	
//	let lens: SimpleLens<Either<String, String>, String> = Either._both()
//	
//	let leftUpper = left
//	|> update(lens) { $0.uppercased() }
//	|> get(lens)
//	let rightUpper = right
//	|> update(lens) { $0.uppercased() }
//	|> get(lens)
//	
//	XCTAssertEqual(leftUpper, "BLAH")
//	XCTAssertEqual(rightUpper, "BLAH")
//	}*/
//}
//
