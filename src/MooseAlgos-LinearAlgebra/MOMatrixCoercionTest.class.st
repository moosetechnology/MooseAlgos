"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOMatrixCoercionTest,
	#superclass : #TestCase,
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #test }
MOMatrixCoercionTest >> testDouble [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 2.0d.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]

{ #category : #test }
MOMatrixCoercionTest >> testFixedPoint [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 2.0s.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]

{ #category : #test }
MOMatrixCoercionTest >> testFloat [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 2.0.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]

{ #category : #test }
MOMatrixCoercionTest >> testFraction [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 1 / 2.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]

{ #category : #test }
MOMatrixCoercionTest >> testInteger [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 2.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]

{ #category : #test }
MOMatrixCoercionTest >> testLargeInteger [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 2000000000000.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]

{ #category : #test }
MOMatrixCoercionTest >> testPoint [
	
	| m n |
	m := MOColumnMatrix
		new: 4 @ 3
		withAll: 2.
	n := 2 @ 2.
	m + n.
	n + m.
	m - n.
	n - m.
	m * n.
	n * m.
	m / n.
	n / m
]
