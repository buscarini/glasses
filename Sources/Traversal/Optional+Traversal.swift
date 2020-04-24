//
//  Optional+Traversal.swift
//  glasses-iOS Tests
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Optional {
	static func each<B>() -> Traversal<Wrapped?, Wrapped, B, B?> {
		.init(
			get: { s in
				[s].compactMap { $0 }
			},
			update: { f in
				{ s in
					s.map(f)
				}
			}
		)
	}
}
