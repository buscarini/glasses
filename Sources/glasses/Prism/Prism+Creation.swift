//
//  Prism+Creation.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

extension Prism where S == A {
	/// The identity case path for `Root`: a case path that always successfully extracts a root value.
	public static var `self`: SimplePrism<S, A> {
		.init(
			embed: { $0 },
			extract: Optional.some
		)
	}
}

extension Prism where A: RawRepresentable, S == A.RawValue {
	/// Returns a case path for `RawRepresentable` types: a case path that attempts to extract a value that can be represented by a raw value from a raw value.
	public static var rawValue: SimplePrism<S, A> {
		.init(
			embed: { $0.rawValue },
			extract: A.init(rawValue:)
		)
	}
}

extension Prism where A: LosslessStringConvertible, S == String {
	/// Returns a case path for `LosslessStringConvertible` types: a case path that attempts to extract a value that can be represented by a lossless string from a string.
	public static var description: SimplePrism<S, A> {
		.init(
			embed: { $0.description },
			extract: A.init
		)
	}
}
