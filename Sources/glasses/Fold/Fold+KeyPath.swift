//
//  Fold+KeyPath.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public func fold<S, A>(
	_ keyPath: KeyPath<S, A>
) -> Fold<S, A> {
	.init { s in
		[
			s[keyPath: keyPath]
		]
	}
}

public func fold<S, A>(
	_ keyPath: KeyPath<S, [A]>
) -> Fold<S, A> {
	.init { s in
		s[keyPath: keyPath]
	}
}
