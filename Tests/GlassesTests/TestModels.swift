import Foundation

struct Person: Equatable {
	var name: String
	var age: Int
}

struct Company: Equatable {
	var employees: [Person]
	var freelance: [Person]
	var ceo: Person
	var cto: Person
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

var company = Company(
	employees: [ mike, louis, jessica ],
	freelance: [ john, joe, mike ],
	ceo: jessica,
	cto: harvey
)
