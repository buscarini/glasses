//
//  Prism+Operator.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

prefix operator /

public prefix func / <S, A>(
	embed: @escaping (A) -> S
) -> SimplePrism<S, A> {
	.case(embed)
}

/// Returns a void case path for a case with no associated value.
///
/// - Note: This operator is only intended to be used with enum cases that have no associated values. Its behavior is otherwise undefined.
/// - Parameter root: A case with no an associated value.
/// - Returns: A void case path.
public prefix func / <Root>(
	root: Root
) -> SimplePrism<Root, Void> {
	.case(root)
}

/// Returns the identity case path for the given type. Enables `/MyType.self` syntax.
///
/// - Parameter type: A type for which to return the identity case path.
/// - Returns: An identity case path.
public prefix func / <Root>(
	type: Root.Type
) -> SimplePrism<Root, Root> {
	.self
}

/// Identifies and returns a given case path. Enables shorthand syntax on static case paths, _e.g._ `/.self`  instead of `.self`.
///
/// - Parameter type: A type for which to return the identity case path.
/// - Returns: An identity case path.
public prefix func / <Root>(
	type: SimplePrism<Root, Root>
) -> SimplePrism<Root, Root> {
	.self
}

/// Returns a function that can attempt to extract associated values from the given enum case initializer.
///
/// Use this operator to create new transform functions to pass to higher-order methods like `compactMap`:
///
///     [Result<Int, Error>.success(42), .failure(MyError()]
///       .compactMap(/Result.success)
///     // [42]
///
/// - Note: This operator is only intended to be used with enum case initializers. Its behavior is otherwise undefined.
/// - Parameter case: An enum case initializer.
/// - Returns: A function that can attempt to extract associated values from an enum.
public prefix func / <Root, Value>(
	case: @escaping (Value) -> Root
) -> (Root) -> Value? {
	extract(`case`)
}

/// Returns a void case path for a case with no associated value.
///
/// - Note: This operator is only intended to be used with enum cases that have no associated values. Its behavior is otherwise undefined.
/// - Parameter root: A case with no an associated value.
/// - Returns: A void case path.
public prefix func / <Root>(
	root: Root
) -> (Root) -> Void? {
	(/root)._extract
}

precedencegroup SimplePrismCompositionPrecedence {
	associativity: right
}

infix operator ..: SimplePrismCompositionPrecedence

extension SimplePrism {
	/// Returns a new case path created by appending the given case path to this one.
	///
	/// The operator version of `SimplePrism.appending(path:)`. Use this method to extend this case path to the value type of another case path.
	///
	/// - Parameters:
	///   - lhs: A case path from a root to a value.
	///   - rhs: A case path from the first case path's value to some other appended value.
	/// - Returns: A new case path from the first case path's root to the second case path's value.
	public static func .. <AppendedValue>(
		lhs: SimplePrism<S, A>,
		rhs: SimplePrism<A, AppendedValue>
	) -> SimplePrism<S, AppendedValue> {
		lhs.compose(rhs)
	}
	
	/// Returns a new case path created by appending the given embed function.
	///
	/// - Parameters:
	///   - lhs: A case path from a root to a value.
	///   - rhs: An embed function from an appended value
	/// - Returns: A new case path from the first case path's root to the second embed function's value.
	public static func .. <AppendedValue>(
		lhs: SimplePrism<S, A>,
		rhs: @escaping (AppendedValue) -> A
	) -> SimplePrism<S, AppendedValue> {
		lhs.compose(.case(rhs))
	}
}

/// Returns a new extract function by appending the given extract function with an embed function.
///
/// Useful when composing extract functions together.
///
///     [Result<Int?, Error>.success(.some(42)), .success(nil), .failure(MyError())]
///       .compactMap(/Result.success..Optional.some)
///     // [42]
///
/// - Parameters:
///   - lhs: An extract function from a root to a value.
///   - rhs: An embed function from some other appended value to the extract function's value.
/// - Returns: A new extract function from the first extract function's root to the second embed function's appended value.
public func .. <Root, Value, AppendedValue>(
	lhs: @escaping (Root) -> Value?,
	rhs: @escaping (AppendedValue) -> Value
) -> (Root) -> AppendedValue? {
	{ root in
		lhs(root).flatMap(extract(rhs))
	}
}
