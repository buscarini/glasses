//
//  Result+Prism.swift
//  glasses-iOS
//
//  Created by José Manuel Sánchez Peñarroja on 25/04/2020.
//  Copyright © 2020 glasses. All rights reserved.
//

import Foundation

public extension Result {
	static func _success<C>() -> Prism<Result<Success, Failure>, Success, C, Result<C, Failure>> {
		.init(
			embed: { c in
				.success(c)
			},
			extract: { s in
				switch s {
				case let .success(succ):
					return succ
				case .failure:
					return nil
				}
			}
		)
	}
	
	static func _failure<E: Error>() -> Prism<Result<Success, Failure>, Failure, E, Result<Success, E>> {
		.init(
			embed: { e in
				.failure(e)
			},
			extract: { s in
				switch s {
				case .success:
					return nil
				case let .failure(f):
					return f
				}
			}
		)
	}
}
