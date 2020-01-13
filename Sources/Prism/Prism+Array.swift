//
//  Array+Prism.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation

public func _first<A>() -> Prism<[A], A, A, [A]> {
	return Prism(get: { (s: [A]) -> A? in
		return s.first
	}, update: { (f: @escaping ((A) -> A)) -> ([A]) -> [A] in
		{ s in
			guard s.count > 0 else { return s }
			
			var result = s
			result[0] = f(result[0])
			return result
		}
	})
}

public func _index<A>(_ index: Int) -> Prism<[A], A, A, [A]> {
	return Prism(get: { (s: [A]) -> A? in
		guard s.count > index else { return nil }
		return s[index]
	}, update: { (f: @escaping ((A) -> A)) -> ([A]) -> [A] in
		{ s in
			guard s.count > index else { return s }
			
			var result = s
			result[index] = f(result[index])
			return result
		}
	})
}
public func _last<A>() -> Prism<[A], A, A, [A]> {
	return Prism(get: { (s: [A]) -> A? in
		return s.last
	}, update: { (f: @escaping ((A) -> A)) -> ([A]) -> [A] in
		{ s in
			guard let last = s.last else { return s }
			
			return s.dropLast() + [ f(last) ]
		}
	})
}

public func _first<A>(where f: @escaping (A) -> Bool) -> Prism<[A], A, A, [A]> {
	return Prism(get: { (s: [A]) in
		return s.first(where: f)
	}, update: { g in
		{ s in
			var result: [A] = []
			var firstTime = true
			for a in s {
				let matches = f(a)
				result.append(matches && firstTime ? g(a) : a)
				if matches { firstTime = false }
			}
			
			return result
		}
	})
}

public func _first<A, P: Equatable>(where keyPath: KeyPath<A, P>, equals value: P) -> Prism<[A], A, A, [A]> {
	return _first(where: { a in
		a[keyPath: keyPath] == value
	})
}

public func _last<A>(where f: @escaping (A) -> Bool) -> Prism<[A], A, A, [A]> {
	return Prism(get: { (s: [A]) in
		return s.filter(f).last
	}, update: { g in
		{ s in
			var result: [A] = []
			var firstTime = true
			for a in s.reversed() {
				let matches = f(a)
				result.append(matches && firstTime ? g(a) : a)
				if matches { firstTime = false }
			}
			
			return result.reversed()
		}
	})
}

public func _last<A, P: Equatable>(where keyPath: KeyPath<A, P>, equals value: P) -> Prism<[A], A, A, [A]> {
	return _last(where: { a in
		a[keyPath: keyPath] == value
	})
}

