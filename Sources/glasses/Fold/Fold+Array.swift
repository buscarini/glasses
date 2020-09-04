//
//  Fold+Array.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Fold {
	func prefix(
		_ prefix: Int
	) -> Fold {
		.init(get: { s in
			Array(self._get(s).prefix(prefix))
		})
	}
	
	func suffix(
		_ suffix: Int
	) -> Fold {
		.init(get: { s in
			Array(self._get(s).suffix(suffix))
		})
	}
}
