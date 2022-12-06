//import UIKit
//
//// MARK: AnyOptic
//
//protocol AnyOptic {
//	associatedtype Whole
//	associatedtype Part
//	associatedtype NewPart
//
//	func `get`(_ whole: Whole) -> Part
//	func update(_ whole: inout Whole, _ f: @escaping (inout NewPart) -> Void) -> Void
//}
//
//
//protocol Getter {
//	associatedtype Whole
//	associatedtype Part
//
//	func `get`(_ whole: Whole) -> Part
//}
//
//protocol Setter {
//	associatedtype Whole
//	associatedtype Part
//	//	associatedtype NewPart
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) -> Void
//}
//
//protocol Optic: Getter, Setter, AnyOptic {
//}
//
//extension Optic {
//	func `set`(_ whole: inout Whole, newValue: Part) {
//		update(&whole) { part in
//			part = newValue
//		}
//	}
//}
//
//struct CombineOptic<LHS: Optic, RHS: Optic>: Optic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> RHS.Part {
//		rhs.get(lhs.get(whole))
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//struct CombineOpticOptional<LHS: Optic, RHS: OptionalOptic>: OptionalOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> RHS.Part? {
//		rhs.get(lhs.get(whole))
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//struct CombineOptionalOptic<LHS: OptionalOptic, RHS: Optic>: OptionalOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> RHS.Part? {
//		lhs.get(whole).map(rhs.get)
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//struct CombineOpticArray<LHS: Optic, RHS: ArrayOptic>: ArrayOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> [RHS.Part] {
//		rhs.get(lhs.get(whole))
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//struct CombineArrayOptic<LHS: ArrayOptic, RHS: Optic>: ArrayOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> [RHS.Part] {
//		lhs.get(whole).map(rhs.get)
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//struct ConcatArrayOptics<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
//where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> [RHS.Part] {
//		lhs.get(whole) + rhs.get(whole)
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole, f)
//		rhs.update(&whole, f)
//	}
//}
//
//struct CombineOptionalArray<LHS: OptionalOptic, RHS: ArrayOptic>: ArrayOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> [RHS.Part] {
//		guard let value = lhs.get(whole) else {
//			return []
//		}
//
//		return rhs.get(value)
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//struct CombineArrayOptional<LHS: ArrayOptic, RHS: Optic>: ArrayOptic
//where LHS.Part == RHS.Whole {
//	let lhs: LHS
//	let rhs: RHS
//
//	typealias Whole = LHS.Whole
//	typealias Part = RHS.Part
//
//	func get(_ whole: LHS.Whole) -> [RHS.Part] {
//		lhs.get(whole).map(rhs.get)
//	}
//
//	func update(
//		_ whole: inout LHS.Whole,
//		_ f: @escaping (inout RHS.Part) -> Void
//	) -> Void {
//		lhs.update(&whole) { lhsPart in
//			rhs.update(&lhsPart, f)
//		}
//	}
//}
//
//extension Optic {
//	func combine<O: Optic>(with optic: O) -> CombineOptic<Self, O>
//	where O.Whole == Part
//	{
//		.init(lhs: self, rhs: optic)
//	}
//}
//
//// MARK: Builder
//
//@resultBuilder
//enum OpticBuilder {
////	static func buildPartialBlock<O: Optic>(first: O) -> O {
////		first
////	}
////
////	static func buildPartialBlock<O0: Optic, O1: Optic>(
////		accumulated o0: O0,
////		next o1: O1
////	) -> CombineOptic<O0, O1> where O0.Part == O1.Whole {
////		.init(lhs: o0, rhs: o1)
////	}
//
//	static func buildPartialBlock<O: Optic>(first optic: O) -> O {
//		optic
//	}
//
//	static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> O {
//		optic
//	}
//
//	static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
//		optic
//	}
//
//	static func buildPartialBlock<O0: Optic, O1: Optic>(accumulated o0: O0, next o1: O1) -> CombineOptic<O0, O1> {
//		CombineOptic(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: Optic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineOpticOptional<O0, O1> {
//		CombineOpticOptional(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: OptionalOptic, O1: Optic>(accumulated o0: O0, next o1: O1) -> CombineOptionalOptic<O0, O1> {
//		CombineOptionalOptic(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: Optic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineOpticArray<O0, O1> {
//		CombineOpticArray(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: ArrayOptic, O1: Optic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptic<O0, O1> {
//		CombineArrayOptic(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
//		ConcatArrayOptics(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: OptionalOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionalArray<O0, O1> {
//		CombineOptionalArray(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptional<O0, O1> {
//		CombineArrayOptional(lhs: o0, rhs: o1)
//	}
//}
//
//
//struct ArrayLiftOptic<O: Optic>: ArrayOptic {
//	let optic: O
//
//	typealias Whole = O.Whole
//	typealias Part = O.Part
//
//	func get(_ whole: Whole) -> [Part] {
//		[
//			optic.get(whole)
//		]
//	}
//
//	func update(
//		_ whole: inout O.Whole,
//		_ f: @escaping (inout O.Part) -> Void
//	) -> Void {
//		optic.update(&whole, f)
//	}
//}
//
//struct ArrayLiftOptional<O: OptionalOptic>: ArrayOptic {
//	let optic: O
//
//	typealias Whole = O.Whole
//	typealias Part = O.Part
//
//	func get(_ whole: Whole) -> [Part] {
//		[
//			optic.get(whole)
//		].compactMap { $0 }
//	}
//
//	func update(
//		_ whole: inout O.Whole,
//		_ f: @escaping (inout O.Part) -> Void
//	) -> Void {
//		optic.update(&whole, f)
//	}
//}
//
//@resultBuilder
//enum ArrayOpticBuilder {
//	static func buildPartialBlock<O: Optic>(first optic: O) -> ArrayLiftOptic<O> {
//		.init(optic: optic)
//	}
//
//	static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayLiftOptional<O> {
//		.init(optic: optic)
//	}
//
//	static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
//		optic
//	}
//
//	static func buildPartialBlock<O0: Optic, O1: Optic>(accumulated o0: O0, next o1: O1) -> ArrayLiftOptic<CombineOptic<O0, O1>> {
//		.init(optic: CombineOptic(lhs: o0, rhs: o1))
//	}
//
//	static func buildPartialBlock<O0: Optic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ArrayLiftOptional<CombineOpticOptional<O0, O1>> {
//		.init(optic: CombineOpticOptional(lhs: o0, rhs: o1))
//	}
//
//	static func buildPartialBlock<O0: OptionalOptic, O1: Optic>(accumulated o0: O0, next o1: O1) -> ArrayLiftOptional<CombineOptionalOptic<O0, O1>> {
//		.init(optic: CombineOptionalOptic(lhs: o0, rhs: o1))
//	}
//
//	static func buildPartialBlock<O0: Optic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineOpticArray<O0, O1> {
//		CombineOpticArray(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: ArrayOptic, O1: Optic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptic<O0, O1> {
//		CombineArrayOptic(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
//		ConcatArrayOptics(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: OptionalOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionalArray<O0, O1> {
//		CombineOptionalArray(lhs: o0, rhs: o1)
//	}
//
//	static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptional<O0, O1> {
//		CombineArrayOptional(lhs: o0, rhs: o1)
//	}
//}
//
//extension KeyPath: Getter {
//	func get(_ whole: Root) -> Value {
//		whole[keyPath: self]
//	}
//}
//
//extension WritableKeyPath: Optic {
////	func get(_ whole: Root) -> Value {
////		whole[keyPath: self]
////	}
//
//	func update(_ whole: inout Root, _ f: @escaping (inout Value) -> Void) {
//		var value = whole[keyPath: self]
//		f(&value)
//		whole[keyPath: self] = value
//	}
//}
//
//struct Optics<Optics: Optic>: Optic {
//	typealias Whole = Optics.Whole
//	typealias Part = Optics.Part
//
//	let optics: Optics
//
//	@inlinable
//	init(@OpticBuilder with build: () -> Optics) {
//		self.optics = build()
//	}
//
//	func get(_ whole: Whole) -> Part {
//		optics.get(whole)
//	}
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.update(&whole, f)
//	}
//}
//
//// MARK: Optional
//
//struct OptionalOptics<Optics: OptionalOptic>: OptionalOptic {
//	typealias Whole = Optics.Whole
//	typealias Part = Optics.Part
//
//	let optics: Optics
//
//	@inlinable
//	init(@OpticBuilder with build: () -> Optics) {
//		self.optics = build()
//	}
//
//	func get(_ whole: Whole) -> Part? {
//		optics.get(whole)
//	}
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.update(&whole, f)
//	}
//}
//
////struct Optionally<Optics: ArrayOptic>: ArrayOptic {
////	typealias Whole = Optics.Whole
////	typealias Part = Optics.Part
////
////	let optics: Optics
////
////	@inlinable
////	init(@OpticBuilder with build: () -> Optics) {
////		self.optics = build()
////	}
////
////	func get(_ whole: Whole) -> [Part] {
////		optics.get(whole)
////	}
////
////	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
////		optics.update(&whole, f)
////	}
////}
//
////struct Optionally<Optics: Optic>: OptionalOptic {
////	typealias Whole = Optics.Whole
////	typealias Part = Optics.Part
////
////	let optics: Optics
////
////	@inlinable
////	init(@OpticBuilder with build: () -> Optics) {
////		self.optics = build()
////	}
////
////	func get(_ whole: Whole) -> Part? {
////		optics.get(whole)
////	}
////
////	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
////		optics.update(&whole, f)
////	}
////}
//
//protocol OptionalOptic {
//	associatedtype Whole
//	associatedtype Part
//
//	func `get`(_ whole: Whole) -> Part?
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) -> Void
//}
//
//extension OptionalOptic {
//	func `set`(_ whole: inout Whole, newValue: Part) {
//		update(&whole) { part in
//			part = newValue
//		}
//	}
//}
//
//struct OptionalDefaultOptic<Wrapped>: OptionalOptic {
//	typealias Whole = Optional<Wrapped>
//	typealias Part = Wrapped
//
//	func get(_ whole: Whole) -> Part? {
//		whole
//	}
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		switch whole {
//			case var .some(value):
//				f(&value)
//				whole = .some(value)
//			case .none:
//				break
//		}
//	}
//}
//
//
//extension Optional {
//	static func optic() -> OptionalDefaultOptic<Wrapped> {
//		.init()
//	}
//}
//
///**********/
//
//// MARK: Arrays
//
//protocol ArrayOptic {
//	associatedtype Whole
//	associatedtype Part
//
//	func `get`(_ whole: Whole) -> [Part]
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) -> Void
//}
//
//extension ArrayOptic {
//	func `set`(_ whole: inout Whole, newValue: Part) {
//		update(&whole) { part in
//			part = newValue
//		}
//	}
//}
//
//struct ArrayDefaultOptic<Element>: ArrayOptic {
//	typealias Whole = Array<Element>
//	typealias Part = Element
//
//	func get(_ whole: Whole) -> [Part] {
//		whole
//	}
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		whole = whole.map { item in
//			var copy = item
//			f(&copy)
//			return copy
//		}
//	}
//}
//
//
//extension Array {
//	static func optic() -> ArrayDefaultOptic<Element> {
//		.init()
//	}
//}
//
//struct ArrayOptics<Optics: ArrayOptic>: ArrayOptic {
//	typealias Whole = Optics.Whole
//	typealias Part = Optics.Part
//
//	let optics: Optics
//
//	@inlinable
//	init(@OpticBuilder with build: () -> Optics) {
//		self.optics = build()
//	}
//
//	func get(_ whole: Whole) -> [Part] {
//		optics.get(whole)
//	}
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.update(&whole, f)
//	}
//}
//
//struct Many<Optics: ArrayOptic>: ArrayOptic {
//	typealias Whole = Optics.Whole
//	typealias Part = Optics.Part
//
//	let optics: Optics
//
//	@inlinable
//	init(@ArrayOpticBuilder with build: () -> Optics) {
//		self.optics = build()
//	}
//
//	func get(_ whole: Whole) -> [Part] {
//		optics.get(whole)
//	}
//
//	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
//		optics.update(&whole, f)
//	}
//}
//
///*************/
//
//struct User {
//	var name: String
//}
//
//
//let userName = Optics {
//	\User.name
//}
//
//var john = User(name: "John")
//
//userName.get(john)
//
//userName.set(&john, newValue: "Anthony")
//
//struct Phone {
//	var number: Int?
//}
//
//let phoneNumber = OptionalOptics {
//	\Phone.number
//	Int?.optic()
//}
//
//var phone = Phone(number: 1234)
//var phoneNone = Phone(number: nil)
//
//phoneNumber.get(phone)
//phoneNumber.get(phoneNone)
//
//phoneNumber.set(&phone, newValue: 12)
//
//phone
//
//phoneNumber.set(&phoneNone, newValue: 25)
//
//phoneNone
//
//struct Group {
//	var users: [User]?
//	var admin: User
//}
//
//var group = Group(
//	users: [
//		.init(name: "John"),
//		.init(name: "Anthony")
//	],
//	admin: .init(name: "Harvey")
//)
//
//let userNames = Many {
//	\User.name
//}
//
////let userNames = ArrayOptics {
////	\User.name
////}
//
//let names = ArrayOptics {
//	\Group.users
//	[User]?.optic()
//	[User].optic()
//	\User.name
//
//	Many {
//		\Group.admin.name
//	}
//}
//
//dump(
//	names.get(group)
//)
//
//names.update(&group) { name in
//	name = name.uppercased()
//}
//
//print(group)
//
//
//
////struct CombineOptics<O: Optic>: Optic {
////	typealias Whole = O.Whole
////	typealias Part = O.Part
////
////	let optic: O
////
////	init(@OpticBuilder build: () -> O) {
////		self.optic = build()
////	}
////
////	func get(_ whole: Whole) -> Part {
////		self.optic.get(whole)
////	}
////
////	func update(_ whole: inout Whole, _ f: @escaping (inout Part) -> Void) {
////		self.optic.update(&whole, f)
////	}
////}
//
//
//
////public struct CombineReducer<LHS: ReducerProtocol, RHS: ReducerProtocol>: ReducerProtocol
////where LHS.State == RHS.State, LHS.Action == RHS.Action
////{
////  let lhs: LHS
////  let rhs: RHS
////
////  public func reduce(into state: inout LHS.State, action: LHS.Action) -> Effect<LHS.Action, Never> {
////	 .merge(
////		self.lhs.reduce(into: &state, action: action),
////		self.rhs.reduce(into: &state, action: action)
////	 )
////  }
////}
//
//
////
////
////struct OpticBuilder: Optic {
////
////
////}
