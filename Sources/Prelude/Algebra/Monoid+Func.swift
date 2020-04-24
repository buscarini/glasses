//
//  Monoid+Func.swift
//  TYRSharedUtils
//
//  Created by José Manuel Sánchez Peñarroja on 01/02/2019.
//  Copyright © 2019 Tyris. All rights reserved.
//

import Foundation

public extension Monoid {
	static func `func`<B>(_ mon: Monoid<B>) -> Monoid<(T) -> B> {
		Monoid<(T) -> B>.init(
			empty: { _ in
				mon.empty
			},
			combine: { f, g in
				{ a in
					mon.combine(f(a), g(a))
				}
			}
		)
	}
}
