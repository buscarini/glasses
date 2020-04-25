
import XCTest
import glasses


class OpticTests: XCTestCase {
	static let theName = "Pepe"
	static let otherName = "Antonio"
	
	static let value = "Blah"

	struct Person: Equatable {
		var id: String
		var name: String
		
		static func == (_ left: Person, _ right: Person) -> Bool {
			return left.id == right.id && left.name == right.name
		}
	}
	
	static var examples: [Person] {
		return [
			Person(id: "1", name: theName),
			Person(id: "2", name: otherName),
			Person(id: "3", name: theName),
		]
	}
	
	static var firstName: SimpleTraversal1<[Person], String> {
		Array._index(1) <<< prop(\Person.name).traversal1()
	}
	
	static func read<O: Optic>(_ o: O) -> (_ entity: O.Root) -> O.Value {
		return o.get
	}
	
	static func write<O: Optic>(_ o: O) -> (_ entity: O.SetterRoot,_ value: O.SetterValue) -> O.SetterNewRoot {
		return o.set
	}
	
//	func testOptic() {
//		let o = OpticTests.firstName
//		
//		let result = OpticTests.examples |> OpticTests.read(o)
//		XCTAssertTrue(result == OpticTests.otherName)
//	}
}

