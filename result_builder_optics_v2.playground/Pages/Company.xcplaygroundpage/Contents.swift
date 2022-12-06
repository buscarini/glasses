////: [Previous](@previous)
//
//import Foundation
//
//// MARK: Data
//struct Person: Equatable {
//	var name: String
//	var age: Int
//}
//
//struct Company: Equatable {
//	var employees: [Person]
//	var ceo: Person
//	var cto: Person
//}
//
//let john = Person(
//	name: "John",
//	age: 55
//)
//
//let joe = Person(
//	name: "Joe",
//	age: 23
//)
//
//let louis = Person(
//	name: "Louis",
//	age: 65
//)
//
//let jessica = Person(
//	name: "Jessica",
//	age: 50
//)
//
//let harvey = Person(
//	name: "Harvey",
//	age: 51
//)
//
//let mike = Person(
//	name: "Mike",
//	age: 38
//)
//
//var company = Company(
//	employees: [ mike, john, joe, louis ],
//	ceo: jessica,
//	cto: harvey
//)
//
//
//// MARK: Optics
//let people = Concat {
//	Many {
//		\Company.employees
//		[Person].optic()
//	}
//	
//	\Company.ceo
//	
//	\Company.cto
//}
//
//dump(
//	people.getAll(company)
//)
//
//
//let oldest = Max {
//	people
//} by: {
//	\Person.age
//}
//
//// MARK: Operations
//oldest.tryGet(company)
//
//oldest.tryUpdate(&company) { person in
//	person.name += " ***"
//}
//
//dump(
//	people.getAll(company)
//)
//
//
//dump(
//	Optionally {
//		oldest
//		\Person.name
//	}.tryGet(company)
//)
//
//let byAge = Many {
//	Reversed {
//		Sorted {
//			people
//		} by: {
//			\Person.age
//		}
//	}
//	
//	\Person.name
//}
//
//dump(
//	byAge.getAll(company)
//)
//
//byAge.updateAll(&company) { name in
//	name = name.uppercased()
//}
//
//dump(
//	byAge.getAll(company)
//)
//
//dump(
//	DroppingWhile {
//		byAge
//	} while: { name in
//		name.count < 6
//	}.getAll(company)
//)
//
//DroppingFirst(3) {
//	byAge
//}.updateAll(&company) { name in
//	name += "!"
//}
//
////DroppingWhile {
////	byAge
////} while: { name in
////	name.count < 6
////}.updateAll(&company) { name in
////	name += "!"
////}
//
//dump(
//	byAge.getAll(company)
//)
//
//
////: [Next](@next)
