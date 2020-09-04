//
//  Optional+Utils.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 27/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Optional {
	func traverse<B>(_ f: @escaping (Wrapped) -> [B]) -> [B?] {
		guard let value = self else {
			return []
		}
		
		return f(value)
	}
}
