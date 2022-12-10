import Foundation

struct Person: Equatable {
	var name: String
	var age: Int
}

enum Failable<T> {
	case valid(T)
	case invalid(Error)
}

extension Failable: Equatable where T: Equatable {
	static func ==(left: Self, right: Self) -> Bool {
		switch (left, right) {
			case let (.valid(left), .valid(right)):
				return left == right
			case let (.invalid(left), .invalid(right)):
				return (left as NSError) == (right as NSError)
			default:
				return false
		}
	}
}

struct Company: Equatable {
	var employees: [Person]
	var freelance: [Person]
	var ceo: Person
	var cto: Person
	var advisor: Failable<Person>?
}

let john = Person(
	name: "John",
	age: 55
)

let joe = Person(
	name: "Joe",
	age: 23
)

let louis = Person(
	name: "Louis",
	age: 65
)

let jessica = Person(
	name: "Jessica",
	age: 50
)

let harvey = Person(
	name: "Harvey",
	age: 51
)

let mike = Person(
	name: "Mike",
	age: 38
)

let company = Company(
	employees: [ mike, louis, jessica ],
	freelance: [ john, joe, mike ],
	ceo: jessica,
	cto: harvey
)
