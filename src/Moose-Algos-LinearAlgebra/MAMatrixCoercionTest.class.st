"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMatrixCoercionTest,
	#superclass : #TestCase,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #test }
MAMatrixCoercionTest >> testDouble [
	"no longer Double in Pharo"
	"| m n |
	m := MAColumnMatrix
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
	n / m"
]

{ #category : #test }
MAMatrixCoercionTest >> testFixedPoint [
	"no longer FixedPoint in Pharo"
	"| m n |
	m := MAColumnMatrix
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
	n / m"
]

{ #category : #test }
MAMatrixCoercionTest >> testFloat [
	
	| m n |
	m := MAColumnMatrix
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
MAMatrixCoercionTest >> testFraction [
	
	| m n |
	m := MAColumnMatrix
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
MAMatrixCoercionTest >> testInteger [
	
	| m n |
	m := MAColumnMatrix
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
MAMatrixCoercionTest >> testLargeInteger [
	
	| m n |
	m := MAColumnMatrix
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
MAMatrixCoercionTest >> testPoint [
	
	| m n |
	m := MAColumnMatrix
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
