//
//  Lens+Prism.swift
//  glasses
//
//  Created by José Manuel Sánchez Peñarroja on 26/10/17.
//

import Foundation

public func withDefault<S, A, B, T>(_ value: A) -> (Prism<S, A, B, T>) -> Lens<S, A, B, T> {
	return { prism in
		return Lens(get: { s in
			return prism._get(s) ?? value
		}, update: { f in
			{ s in
				return update(prism, f)(s)
			}
		})
	}
}

public func ?? <S, A, B, T>(_ prism: Prism<S, A, B, T>, value: A) -> Lens<S, A, B, T> {
	return withDefault(value)(prism)
}

//extension Prism {
/*	public func _default<S, A, B, T>(_ value: A) -> (Prism<S, A, B, T>) -> Lens<S, A, B, T> {
		return { (prism: Prism<S, A, B, T>) -> Lens<S, A, B, T> in
			return Lens<S, A, B, T>(get: { (s: S) -> A in
				let a = get(prism)(s)
				return a ?? value
//				return get(prism, s) ?? value
			}, update: { f in
				{ s in
					return s
//					return update(prism, f)(s)
				}
			})
		}
	}
//}*/

//
//public func <<< <S, A, B, T> (_ left: (Lens<S, A, B, T>) -> Traversal<[S], A, B, [T]>, _ right: Lens<S, A, B, T>) -> Traversal<[S], A, B, [T]> {
//	return left(right)
//}
//
//public func <<< <S, A, B, T> (_ left: (Traversal<S, A, B, T>) -> Traversal<[S], A, B, [T]>, _ right: Traversal<S, A, B, T>) -> Traversal<[S], A, B, [T]> {
//	return left(right)
//}
//

// MARK: Lens + Prism
public func compose<S, A, B, T, C, D>(_ left: Lens<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Prism<S, C, D, T> {
	return Prism(get: { (s: S) -> C? in
		return right._get(left._get(s))
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { a in
				return right._update(f)(a)
			}(s)
		}
	})
}


public func <<< <S, A, B, T, C, D>(_ left: Lens<S, A, B, T>, _ right: Prism<A, C, D, B>) -> Prism<S, C, D, T> {
	return compose(left, right)
}

public func <<< <S, A, C>(_ left: WritableKeyPath<S, A>, _ right: Prism<A, C, C, A>) -> Prism<S, C, C, S> {
	return compose(left.lens, right)
}

public func >>> <S, A, C>(_ left: WritableKeyPath<A, C>, _ right: Prism<S, A, A, S>) -> Prism<S, C, C, S> {
	return compose(right, left.lens)
}

public func >>> <S, A, B, T, C, D>(_ left: Lens<A, C, D, B>, _ right: Prism<S, A, B, T>) -> Prism<S, C, D, T> {
	return compose(right, left)
}


// MARK: Prism + Lens
public func compose<S, A, B, T, C, D>(_ left: Prism<S, A, B, T>, _ right: Lens<A, C, D, B>) -> Prism<S, C, D, T> {
	return Prism(get: { (s: S) -> C? in
		return left._get(s).map(right._get)
	}, update: { (f: @escaping ((C) -> D)) -> (S) -> T in
		{ (s: S) in
			return left._update { a in
				return right._update(f)(a)
			}(s)
		}
	})
}

public func <<< <S, A, B, T, C, D>(_ left: Prism<S, A, B, T>, _ right: Lens<A, C, D, B>) -> Prism<S, C, D, T> {
	return compose(left, right)
}

public func <<< <S, A, B>(_ left: Prism<S, A, A, S>, _ right: WritableKeyPath<A, B>) -> Prism<S, B, B, S> {
	return compose(left, right.lens)
}

public func >>> <S, A, B>(_ left: Prism<A, B, B, A>, _ right: WritableKeyPath<S, A>) -> Prism<S, B, B, S> {
	return compose(right.lens, left)
}

public func >>> <S, A, B, T, C, D>(_ left: Prism<A, C, D, B>, _ right: Lens<S, A, B, T>) -> Prism<S, C, D, T> {
	return compose(right, left)
}



