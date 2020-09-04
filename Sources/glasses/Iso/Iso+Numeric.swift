//
//  Iso+Numeric.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 13/01/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public func adding<N: Numeric>(_ amount: N) -> Iso<N, N> {
	.init(from: { value in
		value - amount
	}) { value in
		value + amount
	}
}

public func subtracting<N: SignedNumeric>(_ amount: N) -> Iso<N, N> {
	adding(amount).reversed
}

public func multiplying<N: BinaryFloatingPoint>(_ amount: N) -> Iso<N, N> {
	.init(from: { value in
		value / amount
	}) { value in
		value * amount
	}
}

public func dividing<N: BinaryFloatingPoint>(_ amount: N) -> Iso<N, N> {
	multiplying(amount).reversed
}

public func negated<N: SignedNumeric>() -> Iso<N, N> {
	.init(from: { value in
		-value
	}) { value in
		-value
	}
}
