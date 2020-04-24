//
//  Fold+Getter.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

extension Fold: Getter {
	public typealias Root = S
	public typealias Value = [A]
	
	public func get(_ s: S) -> [A] {
		return self._get(s)
	}
}
