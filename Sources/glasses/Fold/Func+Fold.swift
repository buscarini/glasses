//
//  Func+Fold.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public func to<S, A>(
	_ f: @escaping (S) -> A
) -> Fold<S, A> {
	.init(get: { s in
		[f(s)]
	})
}
