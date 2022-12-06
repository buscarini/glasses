//: [Previous](@previous)

import Foundation

// MARK: Data
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
//
//let people = Concat {
//	\Company.employees
//	\Company.freelance
//}
//
//people.get(company)




// MARK: Each

//public struct EachOptic<L: Lens, Element>: ArrayOptic
//where L.Part == [Element] {
//	let lens: L
//
//	public typealias Whole = L.Whole
//	public typealias Part = Element
//
//	public func getAll(_ whole: Whole) -> [Part] {
//		lens.get(whole)
//	}
//
//	public func updateAll(
//		_ whole: inout Whole,
//		_ f: @escaping (inout Element) -> Void
//	) -> Void {
//		lens.update(&whole) { array in
//			array = array.map(f)
//		}
//	}
//}

// MARK: Experiment

let people = Concat {
	\Company.employees
	\Company.freelance
}

people
	.droppingFirst(1)
	.get(company)


//people.updateAll(&company) { person in
//	person.name += person.name
//}
//
//people.getAll(company)

let first = First {
	people
}

first.tryUpdate(&company) { person in
	person.name = "1. \(person.name)"
}

people.get(company)

//let oldest = Last {
//	Sorted {
//		people
//	} by: {
//		\Person.age
//	}
//}

let oldest = Max {
	people
} by: {
	\Person.age
}

oldest.tryGet(company)

oldest.tryUpdate(&company) { person in
	person.name = "\(person.name) 👴"
}

people.get(company)



//: [Next](@next)


