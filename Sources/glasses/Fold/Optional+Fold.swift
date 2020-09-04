//
//  Optional+Fold.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Optional {
	static func fold() -> Fold<Wrapped?, Wrapped> {
		.init { s in
			[s].compactMap { $0 }
		}
	}
}
